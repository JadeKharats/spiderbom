require "oauth2"
require "json"

class Auth < Application
  base "/auth"

  get "/login" do
    redirect_to App::OAUTH_CLIENT.get_authorize_uri
  end

  get "/callback" do
    authorization_code = params["code"]
    access_token = App::OAUTH_CLIENT.get_access_token_using_authorization_code(authorization_code)
    client = HTTP::Client.new(App::OAUTH_GITLAB_URI, tls: true)
    access_token.authenticate(client)
    response = client.get "/api/v4/user"
    user = Gluser.from_json(response.body)
    response = client.get "/api/v4/groups?top_level_only=true"
    puts response.body
    welcome_text = "Hello #{user.name}"
    render html: template("welcome.ecr")
  end

end
