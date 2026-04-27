create database if not exists ai_autoQ;

use ai_autoQ;

-- 用户表
create table if not exists user
(
    id            bigint auto_increment comment 'id' primary key,
    userAccount   varchar(256)                           not null comment '账号',
    userPassword  varchar(512)                           not null comment '密码',
    userName      varchar(256)                           null comment '用户昵称',
    userAvatar    varchar(1024)                          null comment '用户头像',
    userProfile   varchar(512)                           null comment '用户简介',
    userRole      varchar(256) default 'user'            not null comment '用户角色：user/admin',
    editTime      datetime     default CURRENT_TIMESTAMP not null comment '编辑时间',
    createTime    datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime    datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete      tinyint      default 0                 not null comment '是否删除',
    vipExpireTime datetime                               null comment '会员过期时间',
    vipCode       varchar(128)                           null comment '会员兑换码',
    vipNumber     bigint                                 null comment '会员编号',
    shareCode     varchar(20)  DEFAULT NULL COMMENT '分享码',
    inviteUser    bigint       DEFAULT NULL COMMENT '邀请用户 id',
    UNIQUE KEY uk_userAccount (userAccount),
    INDEX idx_userName (userName)
) comment '用户' collate = utf8mb4_unicode_ci;

-- 应用表
create table if not exists app
(
    id              bigint auto_increment comment 'id' primary key,
    appName         varchar(128)                       not null comment '应用名',
    appDesc         varchar(2048)                      null comment '应用描述',
    appIcon         varchar(1024)                      null comment '应用图标',
    appType         tinyint  default 0                 not null comment '应用类型（0-得分类，1-测评类）',
    scoringStrategy tinyint  default 0                 not null comment '评分策略（0-自定义，1-AI）',
    reviewStatus    int      default 0                 not null comment '审核状态：0-待审核, 1-通过, 2-拒绝',
    reviewMessage   varchar(512)                       null comment '审核信息',
    reviewerId      bigint                             null comment '审核人 id',
    reviewTime      datetime                           null comment '审核时间',
    userId          bigint                             not null comment '创建用户 id',
    createTime      datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime      datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete        tinyint  default 0                 not null comment '是否删除',
    index idx_appName (appName)
) comment '应用' collate = utf8mb4_unicode_ci;

-- 题目表
create table if not exists question
(
    id              bigint auto_increment comment 'id' primary key,
    questionContent text                               null comment '题目内容（json格式）',
    appId           bigint                             not null comment '应用 id',
    userId          bigint                             not null comment '创建用户 id',
    createTime      datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime      datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete        tinyint  default 0                 not null comment '是否删除',
    index idx_appId (appId)
) comment '题目' collate = utf8mb4_unicode_ci;


-- 评分结果表
create table if not exists scoring_result
(
    id               bigint auto_increment comment 'id' primary key,
    resultName       varchar(128)                       not null comment '结果名称，如物流师',
    resultDesc       text                               null comment '结果描述',
    resultPicture    varchar(1024)                      null comment '结果图片',
    resultProp       varchar(128)                       null comment '结果属性集合 JSON，如 [I,S,T,J]',
    resultScoreRange int                                null comment '结果得分范围，如 80，表示 80及以上的分数命中此结果',
    appId            bigint                             not null comment '应用 id',
    userId           bigint                             not null comment '创建用户 id',
    createTime       datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime       datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete         tinyint  default 0                 not null comment '是否删除',
    index idx_appId (appId)
) comment '评分结果' collate = utf8mb4_unicode_ci;

-- 初始化数据
-- 得分 评分结果初始化
INSERT INTO scoring_result (id, resultName, resultDesc, resultPicture, resultProp, resultScoreRange, createTime, updateTime, isDelete, appId, userId) VALUES (17, '知识大师', '你真棒棒哦，知识掌握地非常出色！', null, null, 9, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0, 2, 1);
INSERT INTO scoring_result (id, resultName, resultDesc, resultPicture, resultProp, resultScoreRange, createTime, updateTime, isDelete, appId, userId) VALUES (18, '地理小能手！', '你对于地理知识了解得相当不错，但还有一些小地方需要加强哦！', null, null, 7, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0, 2, 1);
INSERT INTO scoring_result (id, resultName, resultDesc, resultPicture, resultProp, resultScoreRange, createTime, updateTime, isDelete, appId, userId) VALUES (19, '继续加油！', '还需努力哦', null, null, 0, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0, 2, 1);
INSERT INTO scoring_result (id, resultName, resultDesc, resultPicture, resultProp, resultScoreRange, createTime, updateTime, isDelete, appId, userId) VALUES (20, '继续加油！', '还需努力哦', null, null, 0, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0, 2048698474877124610, 1);

-- 用户答题记录表
create table if not exists user_answer
(
    id              bigint auto_increment primary key,
    appId           bigint                             not null comment '应用 id',
    appType         tinyint  default 0                 not null comment '应用类型（0-得分类，1-角色测评类）',
    scoringStrategy tinyint  default 0                 not null comment '评分策略（0-自定义，1-AI）',
    choices         text                               null comment '用户答案（JSON 数组）',
    resultId        bigint                             null comment '评分结果 id',
    resultName      varchar(128)                       null comment '结果名称，如物流师',
    resultDesc      text                               null comment '结果描述',
    resultPicture   varchar(1024)                      null comment '结果图标',
    resultScore     int                                null comment '得分',
    userId          bigint                             not null comment '用户 id',
    createTime      datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime      datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete        tinyint  default 0                 not null comment '是否删除',
    index idx_appId (appId),
    index idx_userId (userId)
) comment '用户答题记录' collate = utf8mb4_unicode_ci;



INSERT INTO question (questionContent, appId, userId) VALUES

-- E / I
('[{"title":"在社交场合中，你通常：","options":[{"result":"E","score":1,"value":"主动与陌生人交谈","key":"A"},{"result":"I","score":1,"value":"更喜欢和熟人待在一起","key":"B"}]}]', 1, 1),

('[{"title":"周末你更倾向于：","options":[{"result":"E","score":1,"value":"参加聚会或活动","key":"A"},{"result":"I","score":1,"value":"独处或安静休息","key":"B"}]}]', 1, 1),

-- S / N
('[{"title":"你更相信：","options":[{"result":"S","score":1,"value":"实际经验","key":"A"},{"result":"N","score":1,"value":"直觉和灵感","key":"B"}]}]', 1, 1),

('[{"title":"你更喜欢：","options":[{"result":"S","score":1,"value":"具体细节","key":"A"},{"result":"N","score":1,"value":"整体概念","key":"B"}]}]', 1, 1),

-- T / F
('[{"title":"做决定时你更看重：","options":[{"result":"T","score":1,"value":"逻辑分析","key":"A"},{"result":"F","score":1,"value":"他人感受","key":"B"}]}]', 1, 1),

('[{"title":"你认为更重要的是：","options":[{"result":"T","score":1,"value":"公平公正","key":"A"},{"result":"F","score":1,"value":"人情关系","key":"B"}]}]', 1, 1),

-- J / P
('[{"title":"你更喜欢：","options":[{"result":"J","score":1,"value":"提前规划好一切","key":"A"},{"result":"P","score":1,"value":"随性而为","key":"B"}]}]', 1, 1),

('[{"title":"面对任务时你通常：","options":[{"result":"J","score":1,"value":"按计划执行","key":"A"},{"result":"P","score":1,"value":"临时发挥","key":"B"}]}]', 1, 1),

-- 混合题（更真实一点）
('[{"title":"你在团队中更像：","options":[{"result":"E","score":1,"value":"带动气氛的人","key":"A"},{"result":"I","score":1,"value":"默默做事的人","key":"B"}]}]', 1, 1),

('[{"title":"你更倾向于：","options":[{"result":"N","score":1,"value":"思考未来可能性","key":"A"},{"result":"S","score":1,"value":"关注现实情况","key":"B"}]}]', 1, 1);
