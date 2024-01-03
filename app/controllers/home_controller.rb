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
      if @final_output <= 50
        @api_description =
          "Air quality is satisfactory, and air pollution poses little or no risk."
        @api_color = "green"
      end
      if @final_output >= 50 && @final_output <= 100
        @api_description =
          "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
        @api_color = "yellow"
      end
      if @final_output >= 101 && @final_output <= 150
        @api_description =
          "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
        @api_color = "orange"
      end
      if @final_output >= 151 && @final_output <= 200
        @api_description =
          "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
        @api_color = "red"
      end
      if @final_output >= 201 && @final_output <= 300
        @api_description =
          "Health alert: The risk of health effects is increased for everyone."
        @api_color = "purple"
      end
      if @final_output >= 301 && @final_output <= 500
        @api_description =
          "Health warning of emergency conditions: everyone is more likely to be affected."
        @api_color = "maroon"
      end
    end
  end
end
