class HomeController < ApplicationController
  def index
    require "net/http"
    require "json"
    @url =
      "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=25&API_KEY=0126133B-69D1-416C-9A68-6262E4798470"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #check for empty response
    if (@output.empty? || !@output)
      @final_output = "Error"
    else
      @final_output = @output[0]["AQI"]
    end

    if @final_output == "Error"
      @api_color = "gray"
    else
      @api_color = "green" if @final_output <= 50
      @api_color = "yellow" if @final_output >= 50 && @final_output <= 100
      @api_color = "orange" if @final_output >= 101 && @final_output <= 150
      @api_color = "red" if @final_output >= 151 && @final_output <= 200
      @api_color = "purple" if @final_output >= 201 && @final_output <= 300
      @api_color = "maroon" if @final_output >= 301 && @final_output <= 500
    end
  end
end
