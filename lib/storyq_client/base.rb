require 'storyq_client/upload'
require 'storyq_client/token'
require 'storyq_client/resource'
require 'storyq_client/box'
require 'storyq_client/photo'

def StoryQ(*params)
  Storyq::Base.new(*params)
end

module Storyq
  class Base    
    include Token
    
    def initialize(config)
      config[:site] ||= "http://www.storyq.net"
      self.config = config
    end
      
    def slide_boxes
      CallProxy.new(SlideBox, self)
    end
    def photo_boxes
      CallProxy.new(PhotoBox, self)
    end
    def boxes
      CallProxy.new(Box, self)
    end
      
    def post url, body, headers={}
      headers["content-type"] ||= 'application/x-www-form-urlencoded' unless body.blank?
      handle_response access_token.request(:post, url, body, header(headers))
    end
    def put url, body, headers={}
      headers["content-type"] ||= 'application/x-www-form-urlencoded' unless body.blank?
      handle_response access_token.request(:put, url, body, header(headers))
    end
    def delete url, headers={}
      handle_response access_token.request(:delete, url, header(headers))
    end
    def get url, headers={}
      handle_response access_token.request(:get, url, header(headers))
    end
    
    def handle_response(response)
      if response.code=="200"
        response.body
      else
        response.error! 
      end
    end
    
    def header headers
      default_header.merge(headers)
    end
    
    def default_header
      { "accept" => 'application/xml' }
    end
      
  end
  
  class CallProxy
    def initialize(callee, *params)
      @callee, @params = callee, params
    end
    def method_missing(method, *params, &block)
      @callee.send(method, *(params+@params), &block)
    end
  end
end
