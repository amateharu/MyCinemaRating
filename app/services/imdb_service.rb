require 'http'
require 'uri'

# Parses films' attributes from OMDB database
class ImdbService
  def self.response(title)
    response = HTTP.get("http://www.omdbapi.com/?i=tt3896198&apikey=3a1e1da4&t=#{title}").to_s
    JSON.parse(response)
  end
end
