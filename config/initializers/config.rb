APP_CONFIG = {}
APP_CONFIG['LINKEDIN_TOKEN'] = 'g2mhyphkrdgz'
APP_CONFIG['LINKEDIN_SECRET'] = 'juPfNFEearyguLNZ'
APP_CONFIG['LINKEDIN_USER_TOKEN'] = 'd9abeb84-8c5d-4190-b351-b76b2e959f58'
APP_CONFIG['LINKEDIN_USER_SECRET'] = 'dae67e5f-496a-4cfb-82ac-d26f687a4c40'

LINKEDIN_CONFIGURATION = { :site => 'https://api.linkedin.com',
  :authorize_path => '/uas/oauth/authenticate',
  :request_token_path =>'/uas/oauth/requestToken?scope=r_fullprofile+r_emailaddress+r_network+r_contactinfo',
  :access_token_path => '/uas/oauth/accessToken' }

Geokit::default_units = :miles
Geokit::default_formula = :sphere

Geokit::Geocoders::google = 'AIzaSyCezPxXqt_kWkjBmJVveal4fGgngT4keGg'
