create database thesisDb;
use thesisDb;

create table users (
    userId int primary key auto_increment,
    firstName varchar(40) not null,
    lastName varchar(40) not null,
    accountEmail varchar(50) not null,
    accountPassword varchar(255) not null,
    accountEnabled boolean not null
);

create table activities (
    activityId int primary key auto_increment,
    activityDatetime datetime not null,
    activityDescription varchar(200) not null,
    userK int not null,
    foreign key (userK) references users (userId)
);

create table textAnalysis (
    analysisId int primary key auto_increment,
    analysisLanguage varchar(10) not null,
    analysisAddedDate date not null,
    sentiment varchar(10) not null,
    sentimentUpdateDate date,
    sentimentIntensity int,
    emotion varchar(10),
    emotionHide boolean,
    userK int,
    foreign key (userK) references users (userId)
);

create table paragraphs (
    paragraphNumber int,
    analysisK int,
    content text not null,
    paragraphSentiment varchar(10) not null,
    paragraphSentimentIntensity int not null,
    primary key (paragraphNumber, analysisK),
    foreign key (analysisK) references textAnalysis (analysisId)
    on delete cascade
    on update no action
);

create table keywordsCategories (
    categoryId int primary key auto_increment,
    categoryName varchar(255) not null
);

create table keywords (
    keywordId int primary key auto_increment,
    keywordName varchar(100) not null,
    categoryK int not null,
    foreign key (categoryK) references keywordsCategories (categoryId)
    on delete cascade
    on update no action
);

create table keywordsSynonyms (
    synonymId int primary key auto_increment,
    synonymName varchar(100) not null,
    keywordK int not null,
    foreign key (keywordK) references keywords (keywordId)
    on delete cascade
    on update no action
);

create table attendances (
    keywordK int,
    analysisK int,
    primary key (keywordK, analysisK),
    foreign key (keywordK) references keywords (keywordId)
    on delete cascade
    on update no action,
    foreign key (analysisK) references textAnalysis (analysisId)
    on delete cascade
    on update no action
);

create table socialPosts (
	postId varchar(50) primary key,
	socialName varchar(10) not null,
	pubblicationDatetime datetime not null,
	caption text not null,
	nLike int default 0,
	nWow int,
	nSigh int,
	nLove int,
	nHaha int,
	nGrrr int
);

create table postComments (
	commentId varchar(50) primary key,
	commentDatetime datetime not null,
	content text not null,
	nLike int default 0,
	replyTo varchar(50),
	postK varchar(50) not null,
	analysisK int not null,
	foreign key (postK) references socialPosts (postId)
	on delete cascade
    on update no action,
	foreign key (analysisK) references textAnalysis (analysisId)
    on delete cascade
    on update no action
);