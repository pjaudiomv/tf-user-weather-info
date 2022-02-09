locals {
  location_url = "https://www.metaweather.com/api/location/search/?lattlong=${local.location_map.lat},${local.location_map.lon}"

  location_id      = local.location_data[0].woeid
  weather_base_url = "https://www.metaweather.com/api/location"
  weather_url      = var.date != null ? "${local.weather_base_url}/${local.location_id}/${var.date}" : "${local.weather_base_url}/${local.location_id}/"

  location_data         = jsondecode(data.http.fetch_weather_location.body)
  full_weather_data     = jsondecode(data.http.fetch_weather.body)
  selected_weather_data = var.date != null ? local.full_weather_data[0] : local.full_weather_data.consolidated_weather[0]

  weather_temp        = floor((local.selected_weather_data.the_temp * 1.8) + 32)
  weather_description = local.selected_weather_data.weather_state_name

  location_response = jsondecode(data.http.fetch_location.body)
  location_map = {
    lat     = local.location_response["latitude"],
    lon     = local.location_response["longitude"],
    city    = local.location_response["city"],
    region  = local.location_response["region"],
    country = local.location_response["country_code"],
    ip      = local.location_response["ip"],
  }
  location_str = "${local.location_map.city}, ${local.location_map.region}, ${local.location_map.country}"

  weather_report_template = templatefile("${path.root}/weather-report.tpl",
    {
      users_location      = local.location_str
      weather_temp        = local.weather_temp
      weather_description = local.weather_description
      weather_date        = local.selected_weather_data.applicable_date
  })
}
