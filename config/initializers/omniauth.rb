Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :developer unless Rails.env.production?
  provider :linked_in, APP_CONFIG['LINKEDIN_TOKEN'], APP_CONFIG['LINKEDIN_SECRET'], :scope => 'r_fullprofile r_emailaddress r_network', :fields => ["id", "email-address", "summary", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "positions", "educations", "skills"]
end