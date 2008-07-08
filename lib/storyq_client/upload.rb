require "tempfile"
require "fileutils"

module Storyq
  module Upload
    def boundary
      @boundary ||= "----------STORYQ#{rand(1000000000000)}"
    end
        
    def multipart_body(params, boundary)
      params.map do |key, value|
        if value.respond_to?(:original_filename)
          File.open(value.path) do |f|
            f.binmode
            <<-EOF
--#{boundary}\r
Content-Disposition: form-data; name="#{key}"; filename="#{CGI.escape(value.original_filename)}"\r
Content-Type: #{value.content_type}\r
\r
#{f.read}\r
            EOF
          end
        else
          <<-EOF
--#{boundary}\r
Content-Disposition: form-data; name="#{key}"\r
\r
#{value}\r
          EOF
        end
      end.join("")+"--#{boundary}--\r"
    end

    def uploaded_file(path, content_type="application/octet-stream", filename=nil)
      filename ||= File.basename(path)
      t = Tempfile.new(filename)
      FileUtils.copy_file(path, t.path)
      (class << t; self; end;).class_eval do
        alias local_path path
        define_method(:original_filename) { filename }
        define_method(:content_type) { content_type }
      end
      return t
    end
  end
end