class HomeController < ApplicationController
  def index
    require "net/http"
    require "json"
    @url =
      "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=&distance=25&API_KEY=0126133B-69D1-416C-9A68-6262E4798470"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #check for empty response
    if (@output.empty? || !@output)
      @final_output = "Error"
    else
      @final_output = @output[0]["AQI"]
    end
  end
end
