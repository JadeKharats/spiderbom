require "json"

class Gluser
  include JSON::Serializable

  property name : String
  property email : String
  property avatar_url : String
end
