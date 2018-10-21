CREATE TABLE users (
  username VARCHAR(30),
  userDispname VARCHAR(30),
  password VARCHAR(30),
  email  VARCHAR(50),
  enabled CHAR(1)
);

CREATE TABLE user_roles (
  username VARCHAR(30),
  role VARCHAR(30)
);

CREATE TABLE roles (
  role VARCHAR(30),
  description VARCHAR(30)
);

CREATE TABLE plan (
  planid VARCHAR(100),
  status VARCHAR(30),
  templateId VARCHAR(30),
  create_date DATE,
  creator_name VARCHAR(30),
  customer VARCHAR(30),
  notifyNo VARCHAR(30),
  versionNo VARCHAR(30),
  memo VARCHAR(30),
  reviewer_name VARCHAR(30),
  review_date DATE,
  approver_name VARCHAR(30),
  approve_date DATE
);

CREATE TABLE planitem (
  id VARCHAR(100),
  plan_id  VARCHAR(100),
  itemname VARCHAR(100),
  itemvalue VARCHAR(100)
);


CREATE TABLE template (
  id VARCHAR(100),
  name  VARCHAR(100),
  viewname VARCHAR(100),
  notifiyNoFormat VARCHAR(100),
  enabled int,
  creators VARCHAR(400),
  reviewers VARCHAR(400),
  approvers VARCHAR(400),
);