require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class NCU < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPES = %w(user.info.basic.read)

      option :client_options, {
        :site => 'https://api.cc.ncu.edu.tw',
        :authorize_url => 'https://api.cc.ncu.edu.tw/oauth/oauth/authorize',
        :token_url => 'https://api.cc.ncu.edu.tw/oauth/oauth/token'
      }

      option :token_params, {
        :parse => :json
      }

      option :authorize_params, {
        :scope => DEFAULT_SCOPES
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
          params[:scope] = params[:scope].join ' ' if params[:scope]
        end
      end

      uid {
        #raw_info['id'].to_s
        info.hash
      }

      info do
        next {} unless info_allowed?
        {
          'name' => raw_info['name'],
          'type' => raw_info['type'],
          'unit' => raw_info['unit']
        }.merge(raw_info['type'] == 'STUDENT' ? {
          'group' => raw_info['group'],
          'number' => raw_info['number']
        } : {
          'title' => raw_info['title']
        })
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        return {} unless info_allowed?
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('personnel/v1/info').parsed
      rescue ::OAuth2::Error => e
        Logger.new(STDOUT).info e.to_s
        {}
      end

      def info_allowed?
        info_scopes = %w(user.info.basic.read)
        scope = (options['scope'] || DEFAULT_SCOPES)
        (info_scopes & scope).any?
      end
    end
  end
end

OmniAuth.config.add_camelization 'ncu', 'NCU'
