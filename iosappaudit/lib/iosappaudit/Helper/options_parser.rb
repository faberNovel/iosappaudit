module Helper
    class OptionsParser
        def parse(options)
            default_properties = JSON.parse(YAML::load_file("../default_configuration.yaml").to_json, object_class: Hash)
            properties = JSON.parse(YAML::load_file(options[:url]).to_json, object_class: Hash)
            default_properties.merge! properties
            symbolizeOptions default_properties
        end

        def symbolizeOptions(options)
            options.inject({}) { |new_hash, key_value|
                key, value = key_value
                value = symbolizeOptions(value) if value.is_a?(Hash)
                new_hash[key.to_sym] = value
                new_hash
            }
        end
    end
end