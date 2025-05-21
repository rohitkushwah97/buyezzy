module BxBlockContentModeration
	class ImageModerator
		require 'json'
		require 'net/http'
		require 'openssl'

		def check(x)
			api_user_key = ENV['SIGHTENGINE_API_USER_KEY']
			api_secret = ENV['SIGHTENGINE_API_SECRET']

			return false if api_user_key.blank? || api_secret.blank?

			form_data = [['media', File.open(x.path)],["models","nudity-2.0,wad"],["api_user", api_user_key],["api_secret",api_secret]]
			# By editing the params of the models key, we change the flags we need to check the image for.
			# Refer to https://sightengine.com/docs/getstarted for details
			uri = URI('https://api.sightengine.com/1.0/check.json')
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			request = Net::HTTP::Post.new(uri)
			request.set_form form_data, 'multipart/form-data'
			response = http.request(request)
			image_response = response.read_body
			check_guidelines(image_response)

		end

		def check_guidelines(response)
			flags = JSON.parse(response)
			# Edit the values of the confidence of the flags as well.
	        if (flags['nudity']['none'] < 0.8) or (flags['weapon'] > 0.8) or (flags['alcohol'] > 0.8)
	          return 0
	        else
	          return 1
	        end
    	end
	end
end
