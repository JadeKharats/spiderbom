class Auth < Application
  base "/auth"

  get "/login" do
    redirect_to App::OAUTH_CLIENT.get_authorize_uri
  end

  get "/logout" do
    session.clear
    Log.info { session.inspect }
    redirect_to "/"
  end

  get "/callback" do
    authorization_code = params["code"]
    access_token = App::OAUTH_CLIENT.get_access_token_using_authorization_code(authorization_code)
    usertoken = Gitlab::UserToken.new (access_token)
    user = User.find_by(gitlab_id: usertoken.user.id)
    if user
      session["current_user_id"] = user.id
    else
      user = User.new(gitlab_id: usertoken.user.id, name: usertoken.user.name, email: usertoken.user.email, avatar_url: usertoken.user.avatar_url)
      user.save
      session["current_user_id"] = user.id
    end
    welcome_text = "Hello #{usertoken.user.name}"
    render html: template("welcome.ecr")
  end
end
