module RestChain
  module Resource
    attr_reader :context, :original

    def read_attribute(*)
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def attribute?(*)
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def write_attribute(*)
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def update_attributes(*)
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def lazy
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def reload
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end


    def lazy?
      raise NotImplementedError, "If you want to use custom class as RestChain resource, please implement necessary methods. Read README for more info"
    end

    def loaded?
      !lazy?
    end

    def api
      context.api
    end

    def link_to(options= { })
      context.link_to(options)
    end


    def suggest
      context.api.suggestions_for(self)
    end


    def pair(name, client)
      context.pair(name, client)
    end

    def unpair(name, client)
      context.unpair(name, client)
    end


    def follow(name_or_url= nil, params={ }, &block)
      case
        when name_or_url.nil? || name_or_url ==:self
          self_link(self)
        when name_or_url.is_a?(String)
          context.link_to({ 'href' => name_or_url }.merge(params), &block).follow
        when name_or_url.is_a?(Hash) || name_or_url.kind_of?(Resource)
          context.link_to(name_or_url.merge(params), &block).follow
        else
          raise("Oops. The chain is broken :(. Invalid URL to follow! Got: #{name_or_url} ")
      end
    end

    #todo move to the inflection module
    ###########################################################

    def inflect!(object)
      return object unless object.respond_to?(:to_rest_chain)
      inflected = object.to_rest_chain
      inflected.instance_variable_set(:@context, self.context)
      inflected
    end
    ###########################################################

  end
end