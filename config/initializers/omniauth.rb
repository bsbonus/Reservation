require 'omniauth-openid'
require 'openid'
require 'openid/store/filesystem'
require 'gapps_openid'


Rails.application.config.middleware.use Rack::Session::Cookie, :secret => 'supers3cr3t'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id,  :name => 'admin',
                      :identifier => 'https://www.google.com/accounts/o8/site-xrds?hd=goodinc.com',
                      :store => OpenID::Store::Filesystem.new('/tmp')
	end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}