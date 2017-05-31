require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Valkyrie < OmniAuth::Strategies::OAuth2
      option :name, 'valkyrie'
      option :client_options, {
        site:          'http://localhost:3000',
        authorize_url: 'http://localhost:3000/oauth/authorize'
      }
      # option :provider_ignores_state, true

      uid {
        raw_info['id']
      }

      info do
        {
          email: raw_info['email'],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end

      #def callback_url
      #  full_host + script_name + callback_path
      #end

    end
  end
end
