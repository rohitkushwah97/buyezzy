
# if Rails.env.test?
#     require 'mock_redis'
#     $redis_onlines = MockRedis.new
# end

unless Rails.env.test?
  REDIS = Redis::Namespace.new(:my_namespace, redis: Redis.new(host: ENV['REDIS_URL'], port: 6379, db: 0) )
else
  REDIS = Redis::Namespace.new(:my_namespace, redis: MockRedis.new )
end