require 'net/http'

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    raise(ArgumentError, "A regular expression must be supplied as the :format option of the options hash") unless options[:format].nil? or options[:format].is_a?(Regexp)
    configuration = { :message => "is invalid or not responding", :format => URI::regexp(%w(http https)) }
    configuration.update(options)

    if value =~ configuration[:format]
      begin # check header response
        case Net::HTTP.get_response(URI.parse(value))
        when Net::HTTPSuccess then
          if remote_file_is_image?(value) then
            true
          else
            object.errors.add(attribute, configuration[:message]) and false
          end
        else
          object.errors.add(attribute, configuration[:message]) and false
        end
      rescue # Recover on DNS failures..
        object.errors.add(attribute, configuration[:message]) and false
      end
    else
      object.errors.add(attribute, configuration[:message]) and false
    end
  end

  def remote_file_is_image?(url)
    url = URI.parse(url)
    Net::HTTP.start(url.host, url.port) do |http|
      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  end

end
