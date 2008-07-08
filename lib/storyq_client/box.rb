module Storyq
  class Box < Storyq::Resource
    class << self
      def save_params
        %w(title category description tags permission)
      end
      def prefix(type = :url)
        ""
      end
      def collection_name(type = :url)
        prefix(type) + "boxes"
      end
      def singular_name(type = :url)
        prefix(type) + "box"
      end
    end
  end

  class PhotoBox < Storyq::Box
    class << self
      def save_params
        %w(title category description tags permission bgm_url play_interval play_effect, photo_array)
      end
      def prefix(type = :url)
        type == :url ? "photo_" : ""
      end
    end
    
    attr_reader :holder
    def photos
      Storyq::Photo.instantiate_resources(Hash.from_xml(@holder.get("/photo_boxes/#{id}/photos?")), self)
    end
    
    def add_photo attributes
      Storyq::Photo.create attributes, self
    end
  end
 
  class SlideBox < Storyq::Box
    include Storyq::Upload
    
    class << self
      def save_params
        %w(title category description tags permission)
      end
      def prefix(type = :url)
        type == :url ? "slide_" : ""
      end
    end
    
    def parameters
      parameters = super
      if @hash["filename"]
        parameters["slide_box[uploaded_data]"] = uploaded_file(@hash["filename"])
      end
      parameters
    end

    def save
      if new?
        xml = @holder.post("/slide_boxes", multipart_body(parameters, boundary), 
          "content-type" => "multipart/form-data; boundary=#{boundary}")
        @hash["filename"] = nil
      else
        xml = @holder.put("/slide_boxes/#{id}", parameters.to_query)
      end
      @hash = Hash.from_xml(xml)["box"]
      self
    end
  end
end