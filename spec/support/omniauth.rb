module OmniauthTest
  def set_linkedin_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin', 
      :uid => '1234567', 
      :info => {
        :email => 'neil.shah86@gmail.com', 
        :first_name =>  'Neil', 
        :last_name => 'Shah', 
        :name =>  'Neil Shah', 
        :headline =>  'Engineer at Bonobos', 
        :description =>  'Engineer at Bonobos',
        :industry =>  'Internet',
      },
      :credentials => {
        :token => '1234567', 
        :secret => '1234567',
      },
      :extra => {:raw_info => {:skills => {:values => [{:skill => {:name => 'Ruby on Rails'}}]}}}
    })
  end
end