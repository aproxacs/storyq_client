module Storyq
  module Token
    def access_token
      @access_token ||= create_access_token
    end
    
    def access_token=(token)
      @access_toke = token
    end
    
    def config=(config)
      @config = config
    end
      
    def create_access_token
      if access_key and access_secret
        OAuth::AccessToken.new consumer, access_key, access_secret
      else
        authorize
      end
    end
      
    def access
      {"key" => access_key, "secret" => access_secret}
    end
    
    def access=(access)
      @config[:access_key] = access["key"]
      @config[:access_secret] = access["secret"]
    end
    
    def access_key
       @config[:access_key]
    end
    
    def access_secret
      @config[:access_secret]
    end
    
    def consumer
      @consumer ||= OAuth::Consumer.new(
        @config[:consumer_token], @config[:consumer_secret], 
        :site=>@config[:site])      
    end
      
    def authenticate 
      req_token = consumer.get_request_token
      puts "Authorize yourself using the following URL and press any key"
      puts req_token.authorize_url
      gets
      acc_token = req_token.get_access_token
      @config[:access_key] = acc_token.token
      @config[:access_secret] = acc_token.secret      
      acc_token
    rescue Exception => e
      puts e
      return nil
    end    
  end
end
