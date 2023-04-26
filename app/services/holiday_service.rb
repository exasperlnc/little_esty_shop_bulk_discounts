class HolidayService
  def holidays
    get_url("http://date.nager.at/swagger/index.html")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end