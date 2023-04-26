require 'httparty'

class HolidaySearch
  include HTTParty
  def holidays
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  def service
    HolidayService.new
  end
end