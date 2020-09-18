class User
  include JSON::Serializable

  property id : Int64
  property name : String
  property email : String
  property avatar_url : String

  def initialize
    @id = 0
    @name = "Undefined name"
    @email = "Undefined email"
    @avatar_url = "Undefined avatar_url"
  end
end
