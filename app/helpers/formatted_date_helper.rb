module FormattedDateHelper
  private

  def formatted_datetime(value, zone)
    date_time(value).in_time_zone(zone).strftime(date_time_format(value)).strip
  rescue ArgumentError
    value.to_date.strftime(date_format(value)).strip
  end

  def date_time(value)
    DateTime.strptime(value.sub('.000Z', 'Z'))
  end

  def date_time_format(value)
    Date.today.year == value.to_date.year ? "%a %-d %b %l:%M %P" : "%a %-d %b %Y %l:%M %P"
  end

  def date_format(value)
    Date.today.year == value.to_date.year ? "%a %-d %b" : "%a %-d %b %Y"
  end
end
