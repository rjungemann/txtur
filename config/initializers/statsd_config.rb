def statsd_config
  YAML.load_file(Rails.root.join 'config/statsd.yml')[Rails.env]
end

