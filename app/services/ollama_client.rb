require "net/http"
require "uri"
require "json"

class OllamaClient
  BASE_URL = "http://localhost:11434"
  MODEL = "llama3"

  def self.generate_response(prompt)
    uri = URI.parse("#{BASE_URL}/api/generate")

    body = {
      model: MODEL,
      prompt: prompt
    }
    headers = { "Content-Type" => "application/json" }
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = body.to_json

    response_text = ""

    Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(request) do |response|
        response.read_body do |chunk|
          chunk.each_line do |line|
            begin
              data = JSON.parse(line)
              response_text += data["response"] if data["response"]
              break if data["done"]
            rescue JSON::ParserError
              next
            end
          end
        end
      end
      return response_text
    end
  end
end
