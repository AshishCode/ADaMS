OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '833111382217-90o0ig2lb06qadkqecvpps27o4tm2r60.apps.googleusercontent.com', 'gVbwQNCVGkYDQj52PudmAHz8', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end