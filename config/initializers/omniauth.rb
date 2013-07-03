Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :developer unless Rails.env.production?
  provider :linked_in, APP_CONFIG['LINKEDIN_TOKEN'], APP_CONFIG['LINKEDIN_SECRET']
end