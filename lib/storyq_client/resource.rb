module Storyq
  class Resource
    class << self
      def instantiate_resource hash, holder
        new(hash, holder)
      end

      def instantiate_resources hash, holder
        hash[collection_name(:xml)].collect {|res| instantiate_resource(res, holder)}
      end
      
      def create *args
        returning(self.new(*args)) { |res| res.save }
      end
      
      def find(*args)
        holder = args.pop
        scope = args.shift
        options = args.shift || {}
        
        case scope
        when :all then find_every(options, holder)
        when :mine then find_mine(options, holder)
        when :first then find_every(options, holder).first
        else find_single(scope, options, holder)
        end
      end
      
      def find_every(options, holder)
        instantiate_resources(Hash.from_xml(holder.get("/#{collection_name}?" + options.to_query)), holder)
      end
      
      def find_mine(options, holder)
        instantiate_resources(Hash.from_xml(holder.get("/#{collection_name}/mine?" + options.to_query)), holder)
      end    
      
      def find_single(scope, options, holder)
        instantiate_resource(Hash.from_xml(holder.get("/#{collection_name}/#{scope}?" + options.to_query))[singular_name(:xml)], holder)
      end
    end # end of class methods of Resource
    
    def initialize(*args)
      @holder = args.pop
      @hash = args.shift
    end
    
    def update(attributes)
      @hash.update(attributes)
      save
    end
    
    def id
      @hash["identifier"]
    end
    
    def new?
      @hash["identifier"].blank?
    end
    
    def parameters
      returning({}) do |params|
        self.class.save_params.each do |key|
          params["#{self.class.singular_name}[#{key}]"] = @hash[key].to_s unless @hash[key].blank?
        end
      end
    end
    
    def save
      if new?
        xml = @holder.post("/#{self.class.collection_name}/#{id}", parameters)
      else
        xml = @holder.put("/#{self.class.collection_name}/#{id}", parameters)
      end
      
      @hash = Hash.from_xml(xml)[self.class.singular_name(:xml)]
      self
    end
    
    def destroy
      xml = @holder.delete("/#{self.class.collection_name}/#{id}")
      @hash = Hash.from_xml(xml)
    end
    
    def method_missing(method, *args)
      str = method.to_s
      (str[-1] == ?=)? @hash[str[0..-2]] = args[0] : @hash[str]
    end          
  end
end