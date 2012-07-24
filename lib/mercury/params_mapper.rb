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
        hash[key] = map_fields(resource.send(key), value)
        hash
      end
    end

    def map_fields(db_field, content_fields)
      db_field = db_field.gsub(/<%(.+?)%>/m, '&lt;%\1%&gt;')
      db_field = Nokogiri::HTML::DocumentFragment.parse db_field

      content_fields.each do |key, value|
        node = db_field.at_css("div##{key}")
        node.content = value
      end

      CGI.unescapeHTML db_field.to_s
    end

    def normalized_mercury_params
      params[:content].inject({}) do |hash, (key, value)|
        content_field_key = key.match(/^(\w+)_\d+$/)
        if content_field_key
          db_field_key = content_field_key[1]
          hash[db_field_key] ||= {}
          hash[db_field_key].merge!({ key => value[:value] })
        else
          hash[key] = { key => value[:value]}
        end
        hash
      end
    end
  end
end