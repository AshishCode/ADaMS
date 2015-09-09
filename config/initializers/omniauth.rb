OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '833111382217-90o0ig2lb06qadkqecvpps27o4tm2r60.apps.googleusercontent.com', 'gVbwQNCVGkYDQj52PudmAHz8', { scope: 'userinfo.email,userinfo.profile,https://www.google.com/m8/feeds', access_type: 'offline', approval_prompt: '', client_options: {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}, hd: 'akira.co.in' }
end