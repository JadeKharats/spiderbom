class User < Granite::Base
  connection pg
  table users # Name of the table to use for the model, defaults to class name snake cased

  column id : Int64, primary: true # Primary key, defaults to AUTO INCREMENT
  column gitlab_id : Int64
  column email : String
  column name : String
  column avatar_url : String?
end
