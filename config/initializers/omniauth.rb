require 'valkyrie'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :valkyrie, 'cd05d13873743d4bfe7487703b147b8707d40f10a59563879c7fe6f70e8d661a', 'e89e63e9755516202712d3892bfa8924469536edab564778b499c9d2d9d09496'  
end
