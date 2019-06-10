if Rails.env == 'production'
  host = Rails.application.credentials.dig(:redis, :host)
else
  host = "redis"
end

Redis.current = Redis.new(host: host, port: 6379, db: 1)
