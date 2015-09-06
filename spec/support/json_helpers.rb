module JSONHelpers
  def parsed_response
    JSON.parse(last_response.body, symbolize_names: true)
  end

  def response_code
    last_response.status
  end
end
