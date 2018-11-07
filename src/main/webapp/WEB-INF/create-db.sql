CREATE TABLE users (
  username VARCHAR(30),
  userDispname VARCHAR(30),
  password VARCHAR(30),
  email  VARCHAR(50),
  enabled CHAR(1)
);

CREATE TABLE user_role (
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
  updateDate DATE,
  creator_name VARCHAR(30),
  customer VARCHAR(30),
  notifyNo VARCHAR(30),
  versionNo INTEGER,
  memo VARCHAR(30),
  reviewer_name VARCHAR(30),
  review_date DATE,
  reviewStatus INTEGER,
  approver_name VARCHAR(30),
  approve_date DATE,
  approveStatus INTEGER,
  message VARCHAR(200)
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

CREATE TABLE template_creator (
 template_id varchar(100),
 user_id varchar(100)
);

CREATE TABLE template_reviewer (
 template_id varchar(100),
 user_id varchar(100)
);

CREATE TABLE template_approver (
 template_id varchar(100),
 user_id varchar(100)
);