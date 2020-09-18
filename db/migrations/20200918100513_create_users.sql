-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users(
  id BIGSERIAL PRIMARY KEY,
  gitlab_id BIGINT,
  name VARCHAR NOT NULL,
  email VARCHAR NOT NULL,
  avatar_url VARCHAR ,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE users;
