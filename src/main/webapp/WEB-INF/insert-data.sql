INSERT INTO users VALUES ('xwang', '王向伟', '1234', null, '1');
INSERT INTO users VALUES ('test1', '测试1', '1234', null, '1');
INSERT INTO users VALUES ('test2', '测试2', '1234', null, '1');
INSERT INTO users VALUES ('test3', '测试3', '1234', null, '1');

INSERT INTO roles VALUES('ROLE_USER', '一般用户');
INSERT INTO roles VALUES('ROLE_ADMIN', '管理员用户');

INSERT INTO user_role VALUES('xwang', 'ROLE_USER');
INSERT INTO user_role VALUES('xwang', 'ROLE_ADMIN');
INSERT INTO user_role VALUES('xwang2', 'ROLE_USER');

INSERT INTO template VALUES('1', '海信', 'haixin', 'HX%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('2', '杭州涂鸦', 'TYPage', 'TY%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('3', '上海盛本智能科技有限公司', 'ShengBen', 'SB%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('4', '恒强', 'hengqiang', 'HQWW%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('5', '杭州魅奇科技有限公司', 'meiqi', 'MQ%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('6', '杭州古北电子科技有限公司', 'gubei', 'GB-SP%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('7', 'dahua', 'dahua', 'DH%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('8', 'kongke', 'kongke', 'KK%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('9', 'tianyi', 'tianyi', 'TY%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('10', 'wangyi', 'wangyi', 'WY%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('11', 'yufan', 'yufan', 'YF%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('12', 'jingtian', 'jingtian', 'JT%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('13', 'zhongkewei', 'zhongkewei', 'ZKW%yy%%mm%%dd%%02dMB',  1, null, null, null);
INSERT INTO template VALUES('14', 'prosucttask', 'producttask', 'ZNQW%yy%%mm%%dd%%02dMB',  1, null, null, null);


INSERT INTO template_creator VALUES('1', 'xwang');
INSERT INTO template_reviewer VALUES('1', 'xwang')
INSERT INTO template_approver VALUES('1', 'xwang')

INSERT INTO template_creator VALUES('2', 'xwang');
INSERT INTO template_reviewer VALUES('2', 'test1')
INSERT INTO template_reviewer VALUES('2', 'xwang')
INSERT INTO template_approver VALUES('2', 'xwang')

INSERT INTO template_creator VALUES('3', 'xwang');
INSERT INTO template_reviewer VALUES('3', 'xwang');
INSERT INTO template_approver VALUES('3', 'xwang');

INSERT INTO template_creator VALUES('4', 'xwang');
INSERT INTO template_reviewer VALUES('4', 'xwang');
INSERT INTO template_approver VALUES('4', 'xwang');

INSERT INTO template_creator VALUES('5', 'xwang');
INSERT INTO template_reviewer VALUES('5', 'xwang');
INSERT INTO template_approver VALUES('5', 'xwang');

INSERT INTO template_creator VALUES('6', 'xwang');
INSERT INTO template_reviewer VALUES('6', 'xwang');
INSERT INTO template_approver VALUES('6', 'xwang');

INSERT INTO template_creator VALUES('7', 'xwang');
INSERT INTO template_reviewer VALUES('7', 'xwang');
INSERT INTO template_approver VALUES('7', 'xwang');

INSERT INTO template_creator VALUES('8', 'xwang');
INSERT INTO template_reviewer VALUES('8', 'xwang');
INSERT INTO template_approver VALUES('8', 'xwang');

INSERT INTO template_creator VALUES('9', 'xwang');
INSERT INTO template_reviewer VALUES('9', 'xwang');
INSERT INTO template_approver VALUES('9', 'xwang');

INSERT INTO template_creator VALUES('10', 'xwang');
INSERT INTO template_reviewer VALUES('10', 'xwang');
INSERT INTO template_approver VALUES('10', 'xwang');

INSERT INTO template_creator VALUES('11', 'xwang');
INSERT INTO template_reviewer VALUES('11', 'xwang');
INSERT INTO template_approver VALUES('11', 'xwang');

INSERT INTO template_creator VALUES('12', 'xwang');
INSERT INTO template_reviewer VALUES('12', 'xwang');
INSERT INTO template_approver VALUES('12', 'xwang');

INSERT INTO template_creator VALUES('13', 'xwang');
INSERT INTO template_reviewer VALUES('13', 'xwang');
INSERT INTO template_approver VALUES('13', 'xwang');

INSERT INTO template_creator VALUES('14', 'xwang');
INSERT INTO template_reviewer VALUES('14', 'xwang');
INSERT INTO template_approver VALUES('14', 'xwang');
