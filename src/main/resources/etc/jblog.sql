create table users
( 
    userNo number ,
    id varchar2(50) unique,
    userName varchar2(100) not null,
    password varchar2(50) not null,
    joinDate date default sysdate,
    primary key (userNo)
);


create table blog
(
    userNo number not null,
    blogTitle varchar2(200) not null,
    blogFile varchar2(200), 
    primary key (userNo)
);
    alter table blog
    add foreign key (userNo)
    references users (userNo);


create table category
(   
    cateNo number primary key,
    userNo number not null,
    cateName varchar2(200) not null, 
    description varchar2(500),
    regDate date default sysdate
);
    alter table category
    add foreign key (userNo)
    references blog (userNo);
    
    
create table post
(
    postNo number not null,
    cateNo number not null,
    postTitle varchar2(300) not null,
    postContent varchar2(4000),
    regDate date default sysdate,
    primary key (postNo)
);


create table comments
(
    cmtNo number not null,
    postNo number not null,
    cmtContent varchar2(50) not null,
    regDate date default sysdate,
    primary key (cmtNo)
);

    alter table comments
    add foreign key (postNo)
    references post (postNo);


create sequence seq_users_no start with 1 increment by 1;
create sequence seq_category_no start with 1 increment by 1;
create sequence seq_post_no start with 1 increment by 1;
create sequence seq_comments_no start with 1 increment by 1;

--테이블 생성하고 not null 빠진거 추가하기
alter table users modify joinDate not null ;
alter table users modify id not null ;
alter table category modify regDate not null ;
alter table post modify regDate not null ;
alter table comments modify regDate not null ;
