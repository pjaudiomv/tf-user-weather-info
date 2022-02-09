data "http" "fetch_location" {
  url = "https://ipwhois.app/json/"
  request_headers = {
    Accept = "application/json"
  }
}

data "http" "fetch_weather_location" {
  url = local.location_url

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
