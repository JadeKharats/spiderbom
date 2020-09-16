require "action-controller/logger"
require "secrets-env"
require "oauth2"

module App
  NAME    = "BOM"
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify.downcase }}

  Log         = ::Log.for(NAME)
  LOG_BACKEND = ActionController.default_backend

  ENVIRONMENT = ENV["SG_ENV"]? || "development"

  DEFAULT_PORT          = (ENV["SG_SERVER_PORT"]? || 3000).to_i
  DEFAULT_HOST          = ENV["SG_SERVER_HOST"]? || "127.0.0.1"
  DEFAULT_PROCESS_COUNT = (ENV["SG_PROCESS_COUNT"]? || 1).to_i

  STATIC_FILE_PATH = ENV["PUBLIC_WWW_PATH"]? || "./www"

  COOKIE_SESSION_KEY    = ENV["COOKIE_SESSION_KEY"]? || "_spider_gazelle_"
  COOKIE_SESSION_SECRET = ENV["COOKIE_SESSION_SECRET"]? || "4f74c0b358d5bab4000dd3c75465dc2c"

  OAUTH_CLIENT_ID     = ENV["OAUTH_CLIENT_ID"]? || "client_id"
  OAUTH_CLIENT_SECRET = ENV["OAUTH_CLIENT_SECRET"]? || "client_secret"
  OAUTH_REDIRECT_URI  = ENV["OAUTH_REDIRECT_URI"]? || "http://localhost:3000/auth/callback"
  OAUTH_GITLAB_URI    = ENV["OAUTH_GITLAB_URI"]? || "gitlab.com"
  OAUTH_CLIENT        = OAuth2::Client.new(App::OAUTH_GITLAB_URI, App::OAUTH_CLIENT_ID, App::OAUTH_CLIENT_SECRET,
    redirect_uri: App::OAUTH_REDIRECT_URI, authorize_uri: "/oauth/authorize", token_uri: "/oauth/token")

  def self.running_in_production?
    ENVIRONMENT == "production"
  end
end
