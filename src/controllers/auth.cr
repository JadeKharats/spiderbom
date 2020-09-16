class Auth < Application
  base "/auth"

  get "/login" do
    redirect_to App::OAUTH_CLIENT.get_authorize_uri
  end

  get "/callback" do
    authorization_code = params["code"]
    access_token = App::OAUTH_CLIENT.get_access_token_using_authorization_code(authorization_code)
    user = User.new (access_token)
    welcome_text = "Hello #{user.infos.name}"
    render html: template("welcome.ecr")
  end
end
