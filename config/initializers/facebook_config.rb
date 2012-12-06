def facebook_config
  YAML.load_file(Rails.root.join 'config/facebook.yml')[Rails.env]
end

