APP_CONFIG = {}
APP_CONFIG['LINKEDIN_TOKEN'] = 'g2mhyphkrdgz'
APP_CONFIG['LINKEDIN_SECRET'] = 'juPfNFEearyguLNZ'
APP_CONFIG['LINKEDIN_USER_TOKEN'] = 'd9abeb84-8c5d-4190-b351-b76b2e959f58'
APP_CONFIG['LINKEDIN_USER_SECRET'] = 'dae67e5f-496a-4cfb-82ac-d26f687a4c40'
APP_CONFIG['GOOGLE_MAPS_API'] = 'AIzaSyDBeevVCapaxVB5a8m68cx4flA_0kRCnss'

LINKEDIN_CONFIGURATION = { :site => 'https://api.linkedin.com',
  :authorize_path => '/uas/oauth/authenticate',
  :request_token_path =>'/uas/oauth/requestToken?scope=r_fullprofile+r_emailaddress+r_network+r_contactinfo',
  :access_token_path => '/uas/oauth/accessToken' }

Geokit::default_units = :miles
Geokit::default_formula = :sphere

# LINKEDIN ACCESS KEYS
["3c3257fd-a3a9-4224-979d-6c65d173e346", "9f9ebc18-4e5b-4744-8f76-83eed0e55f00"]