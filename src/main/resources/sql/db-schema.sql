DROP SEQUENCE SCHEDULE_SEQ;
DROP TABLE SCHEDULE;
DROP sequence holiday_seq;
DROP table holiday;
DROP TABLE POINT_STAT;
DROP SEQUENCE PAYMENT_SEQ;
DROP TABLE PAYMENT;
DROP SEQUENCE POINT_SEQ;
DROP TABLE POINT;
DROP SEQUENCE TICKET_SEQ;
DROP TABLE TICKET;
DROP SEQUENCE INQUIRY_SEQ;
DROP TABLE INQUIRY;
DROP SEQUENCE QnA_SEQ;
DROP TABLE QnA;
DROP SEQUENCE NOTICE_SEQ;
DROP TABLE NOTICE;
DROP SEQUENCE ISSUE_SEQ;
DROP TABLE ISSUE;
DROP SEQUENCE PROJECT_CHAT_SEQ;
DROP TABLE PROJECT_CHAT;
DROP SEQUENCE FILEBOARD_SEQ;
DROP TABLE FILEBOARD;
DROP SEQUENCE WORKBOARD_COMMENT_SEQ;
DROP TABLE WORKBOARD_COMMENT;
DROP SEQUENCE PROJECT_WORKBOARD_SEQ;
DROP TABLE PROJECT_WORKBOARD;
DROP SEQUENCE PJ_MEM_SEQ;
DROP TABLE PJ_MEM;
DROP SEQUENCE REVIEW_ADMIN_SEQ;
DROP TABLE REVIEW_ADMIN;
--DROP SEQUENCE REVIEW_SEQ;
DROP TABLE REVIEW;
DROP SEQUENCE PORT_DETAIL_SEQ;
DROP TABLE PORT_DETAIL  CASCADE CONSTRAINTS;
DROP SEQUENCE PORTFOLIO_SEQ;
DROP TABLE PORTFOLIO CASCADE CONSTRAINTS;
DROP SEQUENCE PJ_JOB_SEQ;
DROP TABLE PJ_JOB;
DROP SEQUENCE PJ_LOCATION_SEQ;
DROP TABLE PJ_LOCATION;
DROP SEQUENCE PROJECTROOM_SEQ;
DROP TABLE PROJECTROOM CASCADE CONSTRAINTS;
DROP SEQUENCE FOLLOW_SEQ;
DROP TABLE FOLLOW;
DROP SEQUENCE ALARM_SEQ;
DROP TABLE ALARM;
DROP SEQUENCE CATEGORY_2_SEQ;
DROP TABLE CATEGORY_2;
DROP SEQUENCE CATEGORY_1_SEQ;
DROP TABLE CATEGORY_1;
DROP TABLE CATE_NAME;
DROP SEQUENCE TODO_LIST_SEQ;
DROP TABLE TODO_LIST;
DROP TABLE VISIT_STAT;
DROP SEQUENCE F_JOB_SEQ;
DROP TABLE F_JOB;
DROP SEQUENCE F_LOCATION_SEQ;
DROP TABLE favorite;
DROP SEQUENCE favorite_SEQ;
DROP TABLE F_LOCATION;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
---------------------------------------------------------------------------------

-- 유저
CREATE TABLE MEMBER (
   ID        VARCHAR2(50) PRIMARY KEY NOT NULL, -- 이메일ID
   PASSWORD  VARCHAR2(20) NOT NULL, -- 비밀번호
   NAME      VARCHAR2(50) NOT NULL, -- 이름
   BIRTH     DATE     NOT NULL, -- 생년월일
   PHONE     VARCHAR2(20) NOT NULL, -- 폰번호
   PROFILE   VARCHAR2(2000),     -- 자기소개
   U_IMG     VARCHAR2(1000), -- 프로필사진
   BLACKLIST VARCHAR2(10) DEFAULT 'NO',     -- 블랙리스트
    TOTAL_POINT NUMBER         DEFAULT 0,   -- 보유포인트
    MEM_VIEW    NUMBER        default 0,     -- 조회수
   FOLLOWER    NUMBER         default 0,      -- 팔로워수
    eval number default 0.0,
    joindate    date    default sysdate
);


-- 유저 선호지역
CREATE SEQUENCE F_LOCATION_SEQ;
CREATE TABLE F_LOCATION (
   FL_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID     VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 이메일ID
   F_LOC  VARCHAR2(200)           -- 선호지역
);


-- 유저 선호직군
CREATE SEQUENCE F_JOB_SEQ;
CREATE TABLE F_JOB (
   FJ_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID     VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 이메일ID
   F_CATE VARCHAR2(200)           -- 선호직군
);


-- 방문자통계
CREATE TABLE VISIT_STAT (
   VISIT_DATE  DATE PRIMARY KEY NOT NULL, -- 날짜
   COUNT NUMBER DEFAULT 0 NOT NULL -- 방문수
);


-- 마이페이지 유저 할 일
CREATE SEQUENCE TODO_LIST_SEQ;
CREATE TABLE TODO_LIST (
   TODO_NUM VARCHAR2(100)   PRIMARY KEY NOT NULL, -- 번호
   ID       VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 이메일ID
   TODO     VARCHAR2(1000) NOT NULL  -- 할 일
);


-- 카테고리 분류

CREATE TABLE CATE_NAME (
   CATE_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   C_NAME   VARCHAR2(200) NOT NULL  -- 카테고리명
);


-- 카테고리 1차 분류
CREATE SEQUENCE CATEGORY_1_SEQ;
CREATE TABLE CATEGORY_1 (
   CATE_NUM   NUMBER   REFERENCES CATE_NAME(CATE_NUM) on delete cascade NOT NULL, -- 카테고리번호
   CATE_1_NUM NUMBER   PRIMARY KEY NOT NULL, -- 1차번호
   C_1_NAME   VARCHAR2(200) NOT NULL  -- 1차분류
);


-- 카테고리 2차 분류
CREATE SEQUENCE CATEGORY_2_SEQ;
CREATE TABLE CATEGORY_2 (
   CATE_1_NUM NUMBER   REFERENCES CATEGORY_1(CATE_1_NUM) on delete cascade NOT NULL, -- 1차번호
   C_2_NUM    NUMBER   PRIMARY KEY NOT NULL, -- 2차번호
   C_2_NAME   VARCHAR2(200) NOT NULL  -- 2차분류
);


-- 친구( 일방적 팔로잉 )
CREATE SEQUENCE FOLLOW_SEQ;
CREATE TABLE FOLLOW (
   F_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 내이메일ID
   FRIEND_ID VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL  -- 친구이메일ID
);


-- 프로젝트 룸
CREATE SEQUENCE PROJECTROOM_SEQ;
CREATE TABLE PROJECTROOM (
   PJ_NUM    NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NAME   VARCHAR2(500) NOT NULL, -- 프로젝트명
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 팀장
   START_D   DATE     NOT NULL, -- 시작일
   END_D     DATE     NOT NULL, -- 종료일
    REGDATE   DATE     DEFAULT SYSDATE NOT NULL,
   MEM_LIMIT NUMBER   NOT NULL, -- 모집인원
   PJ_INFO   VARCHAR2(2000),           -- 프로젝트소개
    PJ_VIEW   NUMBER             -- 조회수
);


-- 프로젝트 룸 선호 지역
CREATE SEQUENCE PJ_LOCATION_SEQ;
CREATE TABLE PJ_LOCATION (
   PJL_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM  NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프로젝트룸번호
   PJ_LOC  VARCHAR2(1000)           -- 선호지역
);


-- 프로젝트 룸 선호 직군
CREATE SEQUENCE PJ_JOB_SEQ;
CREATE TABLE PJ_JOB (
   PJJ_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM  NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프로젝트룸번호
   PJ_CATE VARCHAR2(1000)           -- 선호직군
);


-- 유저 알림 ( 프로젝트 초대장, 프로젝트 신청 ) 
CREATE SEQUENCE ALARM_SEQ;
CREATE TABLE ALARM (
    A_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
    SENDER    VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 보낸이
    RECEIVER   VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 받는이
     PJ_NUM    NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 내용
    A_DATE    DATE     DEFAULT SYSDATE NOT NULL,  -- 보낸날짜
    A_TYPE    VARCHAR2(30) NOT NULL              --초대알림, 참가알림 유형분류

); 


-- 프로젝트 내 유저 포트폴리오
CREATE SEQUENCE PORTFOLIO_SEQ;
CREATE TABLE PORTFOLIO (
   PORT_NUM  NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 작성자 이메일ID
   SUBJECT   VARCHAR2(500) NOT NULL, -- 제목
   TECH_INFO VARCHAR2(500) NOT NULL, -- 구현기능
   START_D   DATE     NOT NULL, -- 프로젝트시작일
   END_D     DATE     NOT NULL, -- 프로젝트종료일
   FILE_PATH VARCHAR2(1000)     ,     -- 첨부파일경로
   P_PRIVATE   VARCHAR2(10) NOT NULL,  -- 공개여부
    PJ_NUM      NUMBER REFERENCES PROJECTROOM(PJ_NUM) ON DELETE CASCADE NOT NULL        --프로젝트 룸번호
);



-- 포트폴리오 사진 및 설명
CREATE SEQUENCE PORT_DETAIL_SEQ;
CREATE TABLE PORT_DETAIL (
   PD_NUM     NUMBER   NOT NULL, -- 번호
   PORT_NUM   NUMBER   REFERENCES PORTFOLIO(PORT_NUM) on delete cascade NOT NULL, -- 포트폴리오번호
   PD_IMG     VARCHAR2(1000),          -- 이미지경로
   PD_CONTENT VARCHAR2(2000)           -- 이미지설명
);


-- 프로젝트 팀원 평가
--CREATE SEQUENCE REVIEW_SEQ;
CREATE TABLE REVIEW (
   REVIEW_NUM     NUMBER   PRIMARY KEY , -- 번호
   ID             VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 평가자
   TARGET_ID      VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 평가대상
   SCORE          NUMBER   NOT NULL, -- 평점
   REVIEW_CONTENT VARCHAR2(1000) NOT NULL,  -- 평론
    PJ_NUM         NUMBER REFERENCES PROJECTROOM(PJ_NUM) ON DELETE CASCADE NOT NULL     --프로젝트 룸 번호
);


-- 프로젝트 비공개 평가 (TO. 관리자)
CREATE SEQUENCE REVIEW_ADMIN_SEQ;
CREATE TABLE REVIEW_ADMIN (
   RA_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID         VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 유저
   RA_CONTENT VARCHAR2(1000) NOT NULL,  -- 평가내용
    PJ_NUM     NUMBER REFERENCES PROJECTROOM(PJ_NUM) ON DELETE CASCADE NOT NULL     --프로젝트 룸 번호
);


-- 프로젝트 팀원
CREATE SEQUENCE PJ_MEM_SEQ;
CREATE TABLE PJ_MEM (
   PJM_NUM NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM  NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프젝룸번호
   ID      VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL  -- 팀원
);


-- 프로젝트 업무 게시판
CREATE SEQUENCE PROJECT_WORKBOARD_SEQ;
CREATE TABLE PROJECT_WORKBOARD (
   PW_NUM    NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM    NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프젝룸번호
   W_SUBJECT VARCHAR2(500) NOT NULL, -- 업무제목
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 담당자
   W_CONTENT VARCHAR2(2000) NOT NULL, -- 업무내용
   W_DATE    DATE     NOT NULL, -- 마감기한
   STATE     VARCHAR2(20) DEFAULT '진행중' NOT NULL,  -- 진행상태
     pjm_num   number   REFERENCES PJ_MEM(pjm_num) on delete cascade not null
);


-- 프로젝트 업무 게시판 댓글
CREATE SEQUENCE WORKBOARD_COMMENT_SEQ;
CREATE TABLE WORKBOARD_COMMENT (
   WC_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PW_NUM     NUMBER   REFERENCES PROJECT_WORKBOARD(PW_NUM) on delete cascade NOT NULL, -- 업무게시글번호
   ID         VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 글쓴이
   PW_DATE    DATE     DEFAULT SYSDATE NOT NULL, -- 날짜
   WC_CONTENT VARCHAR2(1000)           -- 댓글내용
);


-- 프로젝트 자료실
CREATE SEQUENCE FILEBOARD_SEQ;
CREATE TABLE FILEBOARD (
   FB_NUM    NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM    NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프젝룸번호
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 업로더
   FILENAME  VARCHAR2(1000) NOT NULL, -- 파일명
   FILE_PATH VARCHAR2(1000) NOT NULL, -- 파일경로
   FILE_SIZE VARCHAR2(100) NOT NULL, -- 파일사이즈
   FILE_DATE DATE     DEFAULT SYSDATE NOT NULL,  -- 올린날짜
    pjm_num   number   REFERENCES PJ_MEM(pjm_num) on delete cascade not null
);


-- 프로젝트 채팅방
CREATE SEQUENCE PROJECT_CHAT_SEQ;
CREATE TABLE PROJECT_CHAT (
   CHAT_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
   PJ_NUM       NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL, -- 프젝룸번호
   ID           VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 유저
   CHAT_CONTENT VARCHAR2(2000) NOT NULL, -- 채팅내용
   CHAT_DATE    DATE     DEFAULT SYSDATE NOT NULL  -- 보낸날짜
);


-- 신고 ( 유저, 프로젝트 룸 )
CREATE SEQUENCE ISSUE_SEQ;
CREATE TABLE ISSUE (
   IS_NUM      NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID          VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 신고자
   ISSUE_ID    VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 문제회원
   PJ_NUM      NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade, -- 문제방
   IS_CONTENT  VARCHAR2(1000) NOT NULL,  -- 신고사유
    IS_DATE     DATE DEFAULT SYSDATE NOT NULL    --신고일
);


-- 공지사항
CREATE SEQUENCE NOTICE_SEQ;
CREATE TABLE NOTICE (
   NOTICE_NUM  NUMBER   PRIMARY KEY NOT NULL, -- 번호
   SUBJECT     VARCHAR2(500) NOT NULL, -- 글제목
   CONTENT     VARCHAR2(1000) NOT NULL, -- 글내용
   NOTICE_DATE DATE     DEFAULT SYSDATE NOT NULL  -- 날짜
);


-- QnA
CREATE SEQUENCE QnA_SEQ;
CREATE TABLE QnA (
   QnA_NUM   NUMBER   PRIMARY KEY NOT NULL, -- 번호
   Q_SUBJECT VARCHAR2(500) NOT NULL, -- 글제목
   Q_CONTENT VARCHAR2(1000) NOT NULL  -- 글내용
);


-- 1:1 문의
CREATE SEQUENCE INQUIRY_SEQ;
CREATE TABLE INQUIRY (
   I_NUM      NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID         VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 문의한사람
   I_SUBJECT VARCHAR2(500) NOT NULL, -- 문의제목
   I_CONTENT  VARCHAR2(2000) NOT NULL, -- 문의내용
   I_DATE     DATE     DEFAULT SYSDATE NOT NULL, -- 날짜
   I_STATE    VARCHAR2(20) DEFAULT '미답변'  -- 답변상태
);


--(유저) 티켓 구매 및 사용 내역
CREATE SEQUENCE TICKET_SEQ;
CREATE TABLE TICKET (
   T_NUM    NUMBER       PRIMARY KEY NOT NULL, -- 번호
   ID       VARCHAR2(100) REFERENCES MEMBER(ID) on delete cascade NOT NULL,     -- 구매자
   name     varchar2(100)    null,
   T_DATE   DATE         DEFAULT SYSDATE,     -- 구매일
   T_STATUS VARCHAR2(100) DEFAULT '미사용',     -- 사용여부
   USE_DATE DATE               -- 사용일
);


-- (유저) 포인트 구매 및 사용
CREATE SEQUENCE POINT_SEQ;
CREATE TABLE POINT (
   P_NUM        NUMBER       PRIMARY KEY NOT NULL, -- 번호
   ID           VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 유저
   UPDATE_DATE  DATE         NOT NULL, -- 업데이트일
   TYPE         VARCHAR2(50) NOT NULL, -- 유형
   UPDATE_POINT NUMBER       NOT NULL, -- 업데이트포인트
   AFTER_POINT  NUMBER       NOT NULL  -- 총 포인트
);


-- 결제
CREATE SEQUENCE PAYMENT_SEQ;
CREATE TABLE PAYMENT (
   PAY_NO     NUMBER         PRIMARY KEY NOT NULL, -- 번호
   P_NAME     VARCHAR2(50)   NOT NULL, -- 아이템이름
   PG         VARCHAR2(100)  NOT NULL, -- PG사
   PAY_METHOD VARCHAR2(50)   NOT NULL, -- 결제수단
   REG_DATE   DATE           NULL,     -- 구매일
   ID     VARCHAR2(50)   REFERENCES MEMBER(ID) on delete cascade NOT NULL,     -- 구매자
   PAY_PRICE  NUMBER         NULL,     -- 금액
   IMP_UID    VARCHAR2(1000) NULL,     -- IMP_UID
   STATE      NUMBER         NULL,      -- 성공여부
   name       varchar2(100),
    phone      varchar(20)
);


-- 결제 통계
CREATE TABLE POINT_STAT (
   PAY_DATE  DATE   PRIMARY KEY NOT NULL, -- 날짜
   PAY_PRICE NUMBER       -- 결제금액
);


--스케쥴
create sequence holiday_seq;
create table holiday( -- 일정
    h_num number primary key,
    h_name varchar2(400) not null,
    h_start date not null,
    h_end date not null,
    pj_num number  not null,
    FOREIGN KEY(pj_num) REFERENCES PROJECTROOM(pj_num) on delete cascade
);


CREATE SEQUENCE SCHEDULE_SEQ;
create table schedule( -- 종합스케쥴
    h_num number not null,
    s_date date not null,
    FOREIGN KEY(h_num) REFERENCES holiday(h_num) on delete cascade
);


-- 프로젝트 스크랩테이블
CREATE SEQUENCE favorite_SEQ;
create table favorite(
    Fav_NUM     NUMBER   PRIMARY KEY NOT NULL, -- 번호
   ID        VARCHAR2(50) REFERENCES MEMBER(ID) on delete cascade NOT NULL, -- 내이메일ID
    PJ_NUM    NUMBER   REFERENCES PROJECTROOM(PJ_NUM) on delete cascade NOT NULL -- 방번호
);

------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO VISIT_STAT VALUES('2018/11/14',28);
INSERT INTO VISIT_STAT VALUES('2018/11/15',37);
INSERT INTO VISIT_STAT VALUES('2018/11/16',48);
INSERT INTO VISIT_STAT VALUES('2018/11/17',57);
INSERT INTO VISIT_STAT VALUES('2018/11/18',15);
INSERT INTO VISIT_STAT VALUES('2018/11/19',29);
COMMIT;

INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'공지사항입니다','공지할게없어요','2018/10/12');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'공지사항아닌데요','공지할게없어요','2018/10/13');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'공지사항일까','공지할게없어요','2018/10/14');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'공지사항안해','공지할게없어요','2018/10/15');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'공지사항?','공지할게없어요','2018/10/15');
COMMIT;

INSERT INTO QnA VALUES(QnA_SEQ.NEXTVAL,'비밀번호를 잊어버렸어요','비밀번호 찾기 기능을 이용하세요.');
INSERT INTO QnA VALUES(QnA_SEQ.NEXTVAL,'아이디를 잊어버렸어요','아이디 찾기 기능을 이용하세요.');
INSERT INTO QnA VALUES(QnA_SEQ.NEXTVAL,'Amajoin_us는 무슨 사이트인가요?','IT분야 스터디모임/프로젝트를 위한 협업툴을 제공합니다. 매칭 기능으로 원하던 팀원과 팀을 찾으세요!');
INSERT INTO QnA VALUES(QnA_SEQ.NEXTVAL,'궁금한 사항은 어디에 문의하나요?','1:1 문의 게시판을 참고해주세요.');
INSERT INTO QnA VALUES(QnA_SEQ.NEXTVAL,'블랙리스트는 어떻게 되는건가요?','누적 신고 수 10번이 되면, 블랙리스트로 전환됩니다.');
COMMIT;

INSERT INTO MEMBER VALUES('amajoinus@gmail.com','admin','관리자','1994/10/15','010-5411-3739','관리자입니다',null,'NO',0,0,0,0.0,sysdate);
INSERT INTO MEMBER VALUES('test.amajo@gmail.com','passwd','테스트','1994/10/10','010-5411-3739','안녕하세요. 테스트계정입니다.',null,'NO',0,10,0,0.0,'18/05/11');
INSERT INTO MEMBER VALUES('1@gmail.com','passwd','인기급상승개발자','1994/10/11','010-5411-3739','안녕하세요. 초인기개발자입니다','user2','NO',0,100,1,4.8,'18/05/23');
INSERT INTO MEMBER VALUES('2@gmail.com','passwd','평점좋은개발자','1994/10/11','010-5411-3739','안녕하세요. 인기개발자입니다','user3','NO',0,90,1,5.0,'18/05/11');
INSERT INTO MEMBER VALUES('3@gmail.com','passwd','신인개발자','1994/10/12','010-5411-3739','안녕하세요. 신규개발자입니다','user4','NO',0,10,1,1.0,'18/05/12');
INSERT INTO MEMBER VALUES('5@gmail.com','passwd','제일오래된유저','1994/10/12','010-5411-3739','안녕하세요. 제일오래된유저 입니다','user6','NO',0,10,0,0.0,'17/10/21');
INSERT INTO MEMBER VALUES('6@gmail.com','passwd','블랙리스트유저','1994/10/12','010-5411-3739','안녕하세요. 블랙리스트 입니다','user7','YES',0,10,0,0.0,'18/06/25');
INSERT INTO MEMBER VALUES('7@gmail.com','passwd','우사랑','1974/10/14','010-5411-3739','우사랑 입니다','avatar','NO',0,10,0,3.2,'18/02/24');
INSERT INTO MEMBER VALUES('8@gmail.com','passwd','한여울','1984/10/15','010-5411-3739','한여울 입니다','avatar2','NO',0,10,1,2.0,'18/03/24');
INSERT INTO MEMBER VALUES('9@gmail.com','passwd','우현우','1984/10/16','010-5411-3739','우현우 입니다','avatar3','NO',0,10,1,1.0,'18/04/24');
INSERT INTO MEMBER VALUES('lee@naver.com','passwd','이성희','1954/10/13','010-5411-3739','이성희 입니다','avatar4','NO',0,10,0,3.5,'18/01/24');
INSERT INTO MEMBER VALUES('kim@naver.com','passwd','김민성','1954/10/13','010-5411-3739','김민성 입니다','avatar5','NO',0,10,1,3.5,'18/05/05');
INSERT INTO MEMBER VALUES('4@gmail.com','passwd','방금가입유저','1994/10/12','010-5411-3739','안녕하세요. 방금가입유저 입니다','user5','NO',0,0,1,0.0,sysdate);
COMMIT;


INSERT INTO CATE_NAME VALUES(90, '직군');
INSERT INTO CATE_NAME VALUES(91, '지역');

INSERT INTO CATEGORY_1 VALUES(90,100,'WEB'); 
INSERT INTO CATEGORY_1 VALUES(90,101,'응용프로그래머');
INSERT INTO CATEGORY_1 VALUES(90,102,'데이터베이스');
INSERT INTO CATEGORY_1 VALUES(90,103,'보안');
INSERT INTO CATEGORY_1 VALUES(90,104,'게임');


INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'Spring'); 
INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'Ajax');
INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'ASP');
INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'JSP');
INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'JavaScript');
INSERT INTO CATEGORY_2 VALUES(100,CATEGORY_2_SEQ.NEXTVAL,'XML');

INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'C#');
INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'C');
INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'Java');
INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'DirectX');
INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'Linux');
INSERT INTO CATEGORY_2 VALUES(101,CATEGORY_2_SEQ.NEXTVAL,'안드로이드');

INSERT INTO CATEGORY_2 VALUES(102,CATEGORY_2_SEQ.NEXTVAL,'빅데이터');
INSERT INTO CATEGORY_2 VALUES(102,CATEGORY_2_SEQ.NEXTVAL,'CUBRID');
INSERT INTO CATEGORY_2 VALUES(102,CATEGORY_2_SEQ.NEXTVAL,'DB2');
INSERT INTO CATEGORY_2 VALUES(102,CATEGORY_2_SEQ.NEXTVAL,'MySQL');
INSERT INTO CATEGORY_2 VALUES(102,CATEGORY_2_SEQ.NEXTVAL,'Oracle');

INSERT INTO CATEGORY_2 VALUES(103,CATEGORY_2_SEQ.NEXTVAL,'VPN');
INSERT INTO CATEGORY_2 VALUES(103,CATEGORY_2_SEQ.NEXTVAL,'백신');
INSERT INTO CATEGORY_2 VALUES(103,CATEGORY_2_SEQ.NEXTVAL,'방화벽');
INSERT INTO CATEGORY_2 VALUES(103,CATEGORY_2_SEQ.NEXTVAL,'보안소프트웨어');
INSERT INTO CATEGORY_2 VALUES(103,CATEGORY_2_SEQ.NEXTVAL,'해킹');

INSERT INTO CATEGORY_2 VALUES(104,CATEGORY_2_SEQ.NEXTVAL,'게임개발');
INSERT INTO CATEGORY_2 VALUES(104,CATEGORY_2_SEQ.NEXTVAL,'유니티');
INSERT INTO CATEGORY_2 VALUES(104,CATEGORY_2_SEQ.NEXTVAL,'온라인게임');
INSERT INTO CATEGORY_2 VALUES(104,CATEGORY_2_SEQ.NEXTVAL,'모바일게임');

INSERT INTO CATEGORY_1 VALUES(91,200,'서울시');
INSERT INTO CATEGORY_1 VALUES(91,201,'경기도');
INSERT INTO CATEGORY_1 VALUES(91,202,'인천광역시');
INSERT INTO CATEGORY_1 VALUES(91,203,'충청남도');

INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'강남구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'관악구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'노원구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'종로구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'성북구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'금천구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'영등포구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'용산구');
INSERT INTO CATEGORY_2 VALUES(200,CATEGORY_2_SEQ.NEXTVAL,'중랑구');

INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'부천시 소사구');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'부천시 오정구');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'광명시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'안산시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'군포시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'시흥시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'양주시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'여주시');
INSERT INTO CATEGORY_2 VALUES(201,CATEGORY_2_SEQ.NEXTVAL,'오산시');

INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'강화군');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'계양구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'남구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'남동구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'동구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'부평구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'서구');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'옹진군');
INSERT INTO CATEGORY_2 VALUES(202,CATEGORY_2_SEQ.NEXTVAL,'연수구');

INSERT INTO CATEGORY_2 VALUES(203,CATEGORY_2_SEQ.NEXTVAL,'서산시');
commit;


INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'test.amajo@gmail.com','서울시>종로구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'test.amajo@gmail.com','경기도>부천시 소사구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'test.amajo@gmail.com','충청남도>서산시');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'lee@naver.com','경기도>부천시 소사구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'lee@naver.com','서울시>종로구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'kim@naver.com','서울시>종로구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'kim@naver.com','서울시>영등포구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'1@gmail.com','서울시>중랑구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'2@gmail.com','서울시>용산구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'3@gmail.com','서울시>관악구');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'4@gmail.com','경기도>양주시');
INSERT INTO F_LOCATION VALUES(F_LOCATION_SEQ.NEXTVAL,'5@gmail.com','경기도>광명시');

INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'test.amajo@gmail.com','WEB>Spring');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'test.amajo@gmail.com','WEB>Ajax');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'test.amajo@gmail.com','응용프로그래머>안드로이드');

INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'lee@naver.com','WEB>Spring');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'lee@naver.com','WEB>JavaScript');

INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'kim@naver.com','게임>유니티');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'kim@naver.com','게임>온라인게임');

INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'1@gmail.com','데이터베이스>빅데이터');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'3@gmail.com','응용프로그래머>C');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'2@gmail.com','응용프로그래머>C#');
INSERT INTO F_JOB VALUES(F_JOB_SEQ.NEXTVAL,'4@gmail.com','데이터베이스>Oracle');
------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO TODO_LIST VALUES(TODO_LIST_SEQ.NEXTVAL,'test.amajo@gmail.com','보육정석 CSS 완료하기');
INSERT INTO TODO_LIST VALUES(TODO_LIST_SEQ.NEXTVAL,'test.amajo@gmail.com','숨쉬기ㅠㅠ');
INSERT INTO TODO_LIST VALUES(TODO_LIST_SEQ.NEXTVAL,'test.amajo@gmail.com','업무게시판 지연처리');
INSERT INTO TODO_LIST VALUES(TODO_LIST_SEQ.NEXTVAL,'test.amajo@gmail.com','보육 시나리오 보드 수정하기');
------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO PROJECTROOM VALUES(500,'TEST_PROJECTROOM','test.amajo@gmail.com','2018/9/15','2020/11/21','2020/9/5',7,'모집중입니다',100); 
INSERT INTO PROJECTROOM VALUES(88,'보육의정석','test.amajo@gmail.com','2018/7/15','2018/11/20','2018/6/4',5,'[모집 종료]^-^',100);  
INSERT INTO PROJECTROOM VALUES(157,'완료된 프로젝트 여행가좌','test.amajo@gmail.com','2017/11/16','2017/11/27','2017/10/14',6,'프로젝트 수고많았습니다',100); 

INSERT INTO PROJECTROOM VALUES(111,'불법도박사이트 만드실분?','6@gmail.com','2018/10/14','2018/12/14','2018/10/5',6,'불법사이트 만듭시다',100);

INSERT INTO PROJECTROOM VALUES(112,'인기많은 프로젝트입니다','2@gmail.com','2018/11/10','2019/1/20','2018/10/8',6,'모집중입니다',500); 
INSERT INTO PROJECTROOM VALUES(150,'인기없는 프로젝트입니다','3@gmail.com','2018/11/13','2019/11/11','2018/10/12',6,'모집중입니다',10);

INSERT INTO PROJECTROOM VALUES(156,'시작안한 프로젝트1','7@gmail.com','2018/12/13','2019/01/28','2018/10/11',6,'모집중입니다',100); 
INSERT INTO PROJECTROOM VALUES(168,'시작안한 프로젝트2','8@gmail.com','2018/12/14','2019/01/29','2018/10/12',6,'모집중입니다',100);

INSERT INTO PROJECTROOM VALUES(152,'진행중인 프로젝트1','5@gmail.com','2018/11/14','2018/12/30','2018/10/13',6,'모집중입니다',100);
INSERT INTO PROJECTROOM VALUES(158,'진행중인 프로젝트2','9@gmail.com','2018/11/15','2018/11/30','2018/10/13',6,'모집중입니다',100); 

INSERT INTO PROJECTROOM VALUES(159,'무제한 프로젝트','9@gmail.com','2018/11/15','2099/12/30','2018/10/13',6,'모집중입니다',100); 
INSERT INTO PROJECTROOM VALUES(153,'제일 오래된 프로젝트','4@gmail.com','2017/11/15','2019/10/28','2017/10/19',6,'모집중입니다',100);
INSERT INTO PROJECTROOM VALUES(109,'안드로이드 공부해요','3@gmail.com','2018/11/15','2018/12/21','2018/10/19',6,'모집중입니다',100);
INSERT INTO PROJECTROOM VALUES(154,'안드로이드 프로젝트! 모집중','4@gmail.com','2019/08/28','2019/10/31','2018/08/28',6,'모집중입니다',100);
INSERT INTO PROJECTROOM VALUES(116,'신규개설 프로젝트','3@gmail.com','2018/11/15','2018/12/21',sysdate,6,'모집중입니다',0);

INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'test.amajo@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'1@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'2@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'3@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'4@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'5@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,500,'6@gmail.com');

INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,88,'test.amajo@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,88,'1@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,88,'2@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,88,'3@gmail.com');

INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,157,'test.amajo@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,157,'1@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,157,'2@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,157,'3@gmail.com');

INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,111,'6@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,112,'2@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,150,'3@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,156,'7@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,168,'8@gmail.com');

INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,152,'5@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,158,'9@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,159,'9@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,153,'4@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,154,'4@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,116,'3@gmail.com');
------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,500,'충청남도>서산시');
INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,500,'서울시>종로구');
INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,500,'경기도>부천시 소사구');

INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,88,'충청남도>서산시');
INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,88,'서울시>종로구');

INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,154,'충청남도>서산시');
INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,154,'서울시>종로구');
INSERT INTO PJ_LOCATION VALUES(PJ_LOCATION_SEQ.NEXTVAL,152,'경기도>부천시 소사구');

INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,500,'응용프로그래머>C');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,500,'응용프로그래머>Java');

INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,88,'응용프로그래머>C');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,88,'응용프로그래머>Java');

INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,154,'응용프로그래머>안드로이드');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,154,'WEB>Ajax');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,152,'응용프로그래머>안드로이드');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,109,'응용프로그래머>C');
INSERT INTO PJ_JOB VALUES(PJ_JOB_SEQ.NEXTVAL,116,'응용프로그래머>C');
------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO REVIEW_ADMIN VALUES(REVIEW_ADMIN_SEQ.NEXTVAL,'test.amajo@gmail.com','좋은 툴을 제공해주셔서 잘 사용했습니다. 만족도 100%!!!',157);
INSERT INTO REVIEW_ADMIN VALUES(REVIEW_ADMIN_SEQ.NEXTVAL,'1@gmail.com','캘린더 기능 개선해주세요~ 팀원들이랑 잘 사용했습니다~',157);
INSERT INTO REVIEW_ADMIN VALUES(REVIEW_ADMIN_SEQ.NEXTVAL,'2@gmail.com','채팅 기능, 업무게시판, 자료실 제일 유용하게 사용했어요. 감사합니다',157);
INSERT INTO REVIEW_ADMIN VALUES(REVIEW_ADMIN_SEQ.NEXTVAL,'3@gmail.com','같은 팀원들이 너무 맘에 안들었어요. 다음에는 매칭 기능 이용해볼래요',157);

insert into review_admin values(review_admin_seq.nextval,'test.amajo@gmail.com','드디어 팀프로젝트끝이다~~~ 후련하다~~',88);
insert into review_admin values(review_admin_seq.nextval,'1@gmail.com','드디어 팀프로젝트끝이다~~~ 후련하다~~',88);
insert into review_admin values(review_admin_seq.nextval,'2@gmail.com','수고했다 아마조네스들아~',88);
insert into review_admin values(review_admin_seq.nextval,'3@gmail.com','KH D반 수료일이다~~',88);
commit;

INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'피티 제작하기','test.amajo@gmail.com','발표자료 제작하고 자료실에 올릴 것','2018/11/20','진행중',1);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'보고서 마감','test.amajo@gmail.com','문서화 작업 완료합시다. 요구사항 정의서, erd, 유스케이스 전부','2018/10/13','지연',1);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'면접 질문 준비','test.amajo@gmail.com','모의 면접을 대비해서 기술 질문/인적성 질문 리스트 뽑아오기','2018/10/10','지연',1);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'sql문 확인','test.amajo@gmail.com','sql문 정리해놓기','2018/10/07','완료',1);
INSERT INTO PROJECT_WORKBOARD VALUES(121,500,'깃 연동','1@gmail.com','개인 노트북에 깃 연동해놓기','2018/10/07','완료',2);
INSERT INTO PROJECT_WORKBOARD VALUES(120,500,'알고리즘 풀어오기','1@gmail.com','자료실에 올려둔 알고리즘 풀어오기','2018/10/07','완료',2);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'블랙회원의 글1','6@gmail.com','자료실에 올려둔 알고리즘 풀어오기','2018/10/07','완료',7);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,500,'블랙회원의 글2','6@gmail.com','자료실에 올려둔 알고리즘 풀어오기','2018/10/07','완료',7);
INSERT INTO PROJECT_WORKBOARD VALUES(PROJECT_WORKBOARD_SEQ.NEXTVAL,157,'글 올림','test.amajo@gmail.com','자료실에 올려둔 알고리즘 풀어오기','2018/10/07','완료',12);
commit;


--INSERT INTO FILEBOARD VALUES(FILEBOARD_SEQ.NEXTVAL,88,'test.amajo@gmail.com','아유하기싫어.jpg','C:\Users\user1\Desktop\짤','28.8KB','2018/10/15');
--INSERT INTO FILEBOARD VALUES(FILEBOARD_SEQ.NEXTVAL,88,'test.amajo@gmail.com','아유하기싫어.jpg','C:\Users\user1\Desktop\짤','28.8KB','2018/10/15');
--INSERT INTO FILEBOARD VALUES(FILEBOARD_SEQ.NEXTVAL,88,'test.amajo@gmail.com','아유하기싫어.jpg','C:\Users\user1\Desktop\짤','28.8KB','2018/10/15');
--INSERT INTO FILEBOARD VALUES(FILEBOARD_SEQ.NEXTVAL,88,'test.amajo@gmail.com','아유하기싫어.jpg','C:\Users\user1\Desktop\짤','28.8KB','2018/10/15');

INSERT INTO PROJECT_CHAT VALUES(PROJECT_CHAT_SEQ.NEXTVAL,500,'test.amajo@gmail.com','안녕하세요',SYSDATE);
INSERT INTO PROJECT_CHAT VALUES(PROJECT_CHAT_SEQ.NEXTVAL,500,'test.amajo@gmail.com','반갑습니다',SYSDATE);
INSERT INTO PROJECT_CHAT VALUES(PROJECT_CHAT_SEQ.NEXTVAL,500,'test.amajo@gmail.com','채팅 기능으로 더 활발하게 협업하세요!',SYSDATE);
commit;

INSERT INTO REVIEW VALUES(1,'test.amajo@gmail.com','1@gmail.com',3,'고마웠어요 ',157);
INSERT INTO REVIEW VALUES(2,'test.amajo@gmail.com','2@gmail.com',3,'잘모르겠어요',157);
INSERT INTO REVIEW VALUES(3,'test.amajo@gmail.com','3@gmail.com',3,'잘하시긴 하네요',157);
INSERT INTO REVIEW VALUES(4,'1@gmail.com','test.amajo@gmail.com',3,'시간이 좀.. 잘..안지키셨어요..',157);
INSERT INTO REVIEW VALUES(5,'2@gmail.com','test.amajo@gmail.com',3,'다음에도 만났으면 좋겠네요',157);
INSERT INTO REVIEW VALUES(6,'3@gmail.com','test.amajo@gmail.com',3,'이분 대박입니다 개발자맛집^-^',157);

INSERT INTO WORKBOARD_COMMENT VALUES(WORKBOARD_COMMENT_SEQ.NEXTVAL,120,'test.amajo@gmail.com','2018/10/15','열심히 참여하겠습니다!');
INSERT INTO WORKBOARD_COMMENT VALUES(WORKBOARD_COMMENT_SEQ.NEXTVAL,120,'test.amajo@gmail.com','2018/10/14','내일까지 해보도록 노력할게요..');
INSERT INTO WORKBOARD_COMMENT VALUES(WORKBOARD_COMMENT_SEQ.NEXTVAL,120,'test.amajo@gmail.com','2018/10/13','아마조네스 발표 화이팅!');
INSERT INTO WORKBOARD_COMMENT VALUES(WORKBOARD_COMMENT_SEQ.NEXTVAL,121,'test.amajo@gmail.com','2018/10/12','업무게시판 댓글입니다~');
INSERT INTO WORKBOARD_COMMENT VALUES(WORKBOARD_COMMENT_SEQ.NEXTVAL,121,'test.amajo@gmail.com','2018/10/11','업무게시판 댓글입니다.');


INSERT INTO FOLLOW VALUES(FOLLOW_SEQ.NEXTVAL,'test.amajo@gmail.com','1@gmail.com');
INSERT INTO FOLLOW VALUES(FOLLOW_SEQ.NEXTVAL,'test.amajo@gmail.com','2@gmail.com');
INSERT INTO FOLLOW VALUES(FOLLOW_SEQ.NEXTVAL,'test.amajo@gmail.com','3@gmail.com');
INSERT INTO FOLLOW VALUES(FOLLOW_SEQ.NEXTVAL,'test.amajo@gmail.com','4@gmail.com');

INSERT INTO favorite VALUES(favorite_SEQ.NEXTVAL,'test.amajo@gmail.com',500);
INSERT INTO favorite VALUES(favorite_SEQ.NEXTVAL,'test.amajo@gmail.com',88);

update member set total_point='30000';

insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/20','amajoinus@gmail.com',8000,'imp_786678','1', '관리자', '010-8307-0765');
insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/15','amajoinus@gmail.com',7000,'imp_786678','1', '관리자', '010-8307-0765');
insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/16','amajoinus@gmail.com',8000,'imp_786678','1', '관리자', '010-8307-0765');
insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/17','amajoinus@gmail.com',9000,'imp_786678','1', '관리자', '010-8307-0765');
insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/18','amajoinus@gmail.com',6000,'imp_786678','1', '관리자', '010-8307-0765');
insert into payment values(payment_seq.nextval,'포인트','html5_inicis','card','2018/11/19','amajoinus@gmail.com',7000,'imp_786678','1', '관리자', '010-8307-0765');
insert into point_stat values('2018/11/15',7000);
insert into point_stat values('2018/11/16',8000);
insert into point_stat values('2018/11/17',9000);
insert into point_stat values('2018/11/18',6000);
insert into point_stat values('2018/11/19',7000);
insert into point_stat values('2018/11/20',9100);

INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL,'test.amajo@gmail.com','채팅 기능 문의','채팅 기능은 어떻게 사용하나요?',SYSDATE,'미답변');
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL,'1@gmail.com','억울하게 신고당했어요','블랙리스트가 되어서 기능을 사용할 수 없어요',SYSDATE,'미답변');
commit;

------------------ 포트폴리오---------------------------------

insert into portfolio values(PORTFOLIO_SEQ.nextval,'test.amajo@gmail.com','여행가좌 프로젝트의 포트폴리오 입니다.' ,'Java, javaScript, Ajax, jQuery, Oracle 등 사용',
'2017/11/16','2017/11/27','test.txt','on',157);

insert into PORT_DETAIL values (1,PORTFOLIO_SEQ.currval,'a','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');
insert into PORT_DETAIL values (2,PORTFOLIO_SEQ.currval,'b','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');
insert into PORT_DETAIL values (3,PORTFOLIO_SEQ.currval,'c','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');


----------------------------- ALARM --------------------------------------------------
-- 타 회원이 aa가 팀장인 207 프로젝트에 참가를 원할 때 (receiver==aa) + 참가 // 참가신청 ---------------------------
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'7@gmail.com','test.amajo@gmail.com',500,SYSDATE,'참가'); --cc가 aa의 프로젝트 참가 신청
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'8@gmail.com','test.amajo@gmail.com',88,SYSDATE,'참가');
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'9@gmail.com','test.amajo@gmail.com',88,SYSDATE,'참가');
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'lee@naver.com','test.amajo@gmail.com',88,SYSDATE,'참가');


-- 외부 프로젝트에서 aa를 초대(receiver==aa) // 초대
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'6@gmail.com','test.amajo@gmail.com',111,SYSDATE,'초대');
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'3@gmail.com','test.amajo@gmail.com',109,SYSDATE,'초대');
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'2@gmail.com','test.amajo@gmail.com',112,SYSDATE,'초대');

-- 내가 신청한 프로젝트
INSERT INTO ALARM VALUES(ALARM_SEQ.NEXTVAL,'test.amajo@gmail.com','5@gmail.com',152,SYSDATE,'참가');
commit;
---------------------- 프로젝트룸 + pj_mem + 리뷰
INSERT INTO PROJECTROOM VALUES(200,'웹앱 연계형 서비스' , 'test.amajo@gmail.com','2018/05/16','2018/08/15','2018/05/14',6,'프로젝트 수고많았습니다',100); 


INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,200,'test.amajo@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,200,'1@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,200,'2@gmail.com');
INSERT INTO PJ_MEM VALUES(PJ_MEM_SEQ.NEXTVAL,200,'3@gmail.com');

INSERT INTO REVIEW VALUES(7,'test.amajo@gmail.com','1@gmail.com',2,'엄청 열심히 하심. 열심히만',200);
INSERT INTO REVIEW VALUES(8,'test.amajo@gmail.com','2@gmail.com',4,'덕분에 잘 끝마쳤습니다',200);
INSERT INTO REVIEW VALUES(9,'test.amajo@gmail.com','3@gmail.com',4,'그동안 고생하셨습니다',200);

INSERT INTO REVIEW VALUES(10,'1@gmail.com','test.amajo@gmail.com',5,'코딩왕이심',200);
INSERT INTO REVIEW VALUES(11,'2@gmail.com','test.amajo@gmail.com',4.5,'덕분에 많이 배웠습니다',200);
INSERT INTO REVIEW VALUES(12,'3@gmail.com','test.amajo@gmail.com',4,'어려웠지만 재밌었습니다',200);

INSERT INTO TICKET VALUES(TICKET_SEQ.NEXTVAL,'test.amajo@gmail.com',null, '2018/04/12','미사용',NULL);


commit;


insert into portfolio values(PORTFOLIO_SEQ.nextval,'test.amajo@gmail.com','웹-앱 연계형 서비스 적용과 응용SW 개발 및 구현 프로젝트의 포트폴리오 입니다.' ,'Java, javaScript, Ajax, jQuery, html, jstl등 사용',
'2017/11/16','2017/11/27','test.txt','off',200);

insert into PORT_DETAIL values (1,PORTFOLIO_SEQ.currval,'a','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');
insert into PORT_DETAIL values (2,PORTFOLIO_SEQ.currval,'b','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');
insert into PORT_DETAIL values (3,PORTFOLIO_SEQ.currval,'c','웹 개발자들은 때때로 Ajax를 단순히 웹 페이지의 일부분을 대체하기 위해 사용한다. 비 AJAX 사용자가 전체 페이지를 불러오는 것에 비해 Ajax 사용자는 페이지의 일부분만을 불러올 수가 있다. 이것으로 개발자들이 비 AJAX 환경에 있는 사용자의 접근성을 포함한 경험을 보호할 수 있으며, 적절한 브라우저를 이용하는 경우에 전체 페이지를 불러오는 일 없이 응답성을 향상시킬 수 있다. ');

