module BxBlockContentModeration
	class TextModerator

		def initialize(text,original_text)
			@check_text = text
			@original_text = original_text
		end

		def text_filter
  		filter1 = LanguageFilter::Filter.new matchlist: :sex, replacement: :stars
			filter2 = LanguageFilter::Filter.new matchlist: :hate, replacement: :stars
			filter3 = LanguageFilter::Filter.new matchlist: :violence, replacement: :stars
			filter4 = LanguageFilter::Filter.new matchlist: :profanity, replacement: :stars

			#Passing the text through all the filters. Can be changed according to requirement.
			x= filter1.sanitize(@check_text)
			x= filter2.sanitize(x)
			x= filter3.sanitize(x)
			x= filter4.sanitize(x)
			text_comparator(x)
		end

		def text_comparator(sanitised_text)
			if sanitised_text.eql?@original_text
	  			return 1
	  		else
	  			return 0
	  		end
		end
	end
end
