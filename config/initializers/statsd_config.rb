def statsd_config
  YAML.load_file(Rails.root.join 'config/statsd.yml')[Rails.env]
end

def statsd
  config = statsd_config
  statsd = Statsd.new config['host'], config['port']

  statsd.namespace = config['namespace']

  statsd
end

