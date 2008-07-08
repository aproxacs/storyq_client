module Storyq
  class Photo < Storyq::Resource
    include Storyq::Upload
    
    class << self
      def save_params
        %w(title note)
      end
      
      def collection_name(type = :url)
        "photos"
      end
      def singular_name(type = :url)
        "photo"
      end      
    end

    def initialize(*args)
      @photo_box = args.pop
      @holder = @photo_box.holder
      @hash = args.shift
    end
    
    def parameters
      parameters = super
      if @hash["filename"]
        parameters["photo[uploaded_data]"] = uploaded_file(@hash["filename"])
      end
      parameters
    end    

    def save
      if new?
        p parameters
        xml = @holder.post("/photo_boxes/#{@photo_box.id}/photos", multipart_body(parameters, boundary), 
          "content-type" => "multipart/form-data; boundary=#{boundary}")
        @hash["filename"] = nil
      else
        xml = @holder.put("/photo_boxes/#{@photo_box.id}/photos/#{id}", parameters.to_query)
      end
      @hash = Hash.from_xml(xml)["photo"]
      self
    end
    
    def destroy
      puts "hey"
      xml = @holder.delete("/photo_boxes/#{@photo_box.id}/photos/#{id}")
      @hash = Hash.from_xml(xml)
    end    
  end
end