output "users_location" {
  value = local.location_map
}

output "weather_date" {
  value = local.selected_weather_data.applicable_date
}

output "weather_report" {
  value = local.weather_report_template
}
