%w(rubygems oauth oauth/consumer activesupport yaml).each {|l| require l}

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "storyq_client/base"

module OAuth::RequestProxy::Net
  module HTTP
    class HTTPRequest < OAuth::RequestProxy::Base
      def post_params
        request.body if request.content_type == "application/x-www-form-urlencoded"
      end
    end
  end
end