class UserToken

  property user : User
  property access_token : OAuth2::AccessToken

  def initialize(access_token)
    @access_token = access_token
    @user = User.new
    get_oauth_infos
  end

  def get_oauth_infos
    client = HTTP::Client.new(App::OAUTH_GITLAB_URI, tls: true)
    @access_token.authenticate(client)
    response = client.get "/api/v4/user"
    @user = User.from_json(response.body)
  end
end
