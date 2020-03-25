GoogleDistanceMatrix.configure_defaults do |config|
  config.mode = 'walking'
  config.google_api_key = Rails.application.credentials.google_maps_api_key
end