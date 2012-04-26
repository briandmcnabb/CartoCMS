module Mercury
  module ParamsMapper
    private

    def mercury_update?
      params[:content]
    end

    def normalize_params_hash(resource)
      resource_key = resource.class.to_s.downcase.to_sym
      nmp = normalized_mercury_params

      params[resource_key] = nmp.inject(nmp) do |hash, (key, value)|
        hash[key] = map_virtual_fields(resource.send(key), value) if value.is_a?(Hash)
        hash
      end
    end

    def map_virtual_fields(parent_field, virtual_fields)
      parent_field = parent_field.gsub(/<%(.+?)%>/m, '&lt;%\1%&gt;')
      parent_field = Nokogiri::HTML::DocumentFragment.parse parent_field

      virtual_fields.each do |key, value|
        node = parent_field.at_css("div##{key}")
        node.content = value
      end

      CGI.unescapeHTML parent_field.to_s
    end

    def normalized_mercury_params
      params[:content].inject({}) do |hash, (key, value)|
        virtual_key = key.match(/^(\w+)_\d+$/)
        if virtual_key
          parent_key = virtual_key[1]
          hash[parent_key] ||= {}
          hash[parent_key].merge!({ key => value[:value] })
        else
          hash[key] = value[:value]
        end
        hash
      end
    end
  end
end