require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Valkyrie < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'global'
      option :name, 'valkyrie'
      option :client_options, {
        site:          'http://localhost:3000',
        authorize_url: '/oauth/authorize'
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

      # def token_params
      #   raise "CIBAI"
      # end
      # def uid
      #   raise "CHICKYOUT"
      # end

    #   def callback_phase # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
    #    error = request.params["error_reason"] || request.params["error"]
    #    if error
    #      fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
    #    elsif !options.provider_ignores_state && (request.params["state"].to_s.empty? || request.params["state"] != session.delete("omniauth.state"))
    #      fail!(:csrf_detected, CallbackError.new(:csrf_detected, "CSRF detected"))
    #    else
    #      raise "KANINE"
    #      self.access_token = build_access_token
    #      self.access_token = access_token.refresh! if access_token.expired?
    #      super
    #    end
    #  rescue ::OAuth2::Error, CallbackError => e
    #    fail!(:invalid_credentials, e)
    #  rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
    #    fail!(:timeout, e)
    #  rescue ::SocketError => e
    #    fail!(:failed_to_connect, e)
    #  end

      # def callback_phase
      #   raise auth_hash.inspect
      #   super
      # end

      def callback_url
       full_host + script_name + callback_path
      end

    end
  end
end
