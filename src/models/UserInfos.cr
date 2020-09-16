class UserInfos
  include JSON::Serializable

  property name : String
  property email : String
  property avatar_url : String

  def initialize()
    @name = "Undefined name"
    @email = "Undefined email"
    @avatar_url = "Undefined avatar_url"
  end
end
