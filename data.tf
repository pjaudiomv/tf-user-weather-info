data "http" "fetch_location" {
  url = "http://ip-api.com/json/"
  request_headers = {
    Accept = "application/json"
  }
}

data "http" "fetch_weather" {
  url = local.weather_url

  request_headers = {
    Accept = "application/json"
  }
}
