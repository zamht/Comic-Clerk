

select*from COMIC_EMPLOYEE;
desc COMIC_EMPLOYEE;
drop table COMIC_EMPLOYEE CASCADE CONSTRAINTS;
drop table COMIC_WORKINGHOUR;
drop table COMIC_PRODUCTORDER;
drop table COMIC_PRODUCTSTOCK;
drop table COMIC_BOOK;
drop table COMIC_ROOM CASCADE CONSTRAINTS;
drop table COMIC_ROOMUSE;
drop table COMIC_ORDER;
drop table COMIC_PRODUCTSALES;
drop table COMIC_ROOMSALES CASCADE CONSTRAINTS;
drop table COMIC_CHAT;
drop table COMIC_LOSS;
drop table COMIC_COMMENTS;
drop table COMIC_PAY;
drop table COMIC_BOARD;
drop table COMIC_MEMBER CASCADE CONSTRAINTS;

CREATE TABLE COMIC_MEMBER (--ȸ��
	MEMBER_ID VARCHAR2(20) PRIMARY KEY, --���̵�
	MEMBER_PWD VARCHAR2(30) NOT NULL, --��й�ȣ
	MEMBER_NAME VARCHAR2(30) NOT NULL, --�̸�
	MEMBER_EMAIL VARCHAR2(30) UNIQUE, --�̸���
	MEMBER_PHONE_NUMBER VARCHAR2(30) NOT NULL --����ó
);

--����
CREATE TABLE COMIC_EMPLOYEE (
    EMPLOYEE_NUM NUMBER DEFAULT 1000 PRIMARY KEY, --�������
    EMPLOYEE_PWD VARCHAR(30) NOT NULL, -- ��й�ȣ
    EMPLOYEE_NAME VARCHAR2(30) NOT NULL, --�̸�
    EMPLOYEE_PHONE VARCHAR2(30) NOT NULL, --����ó
    EMPLOYEE_ACCOUNT VARCHAR2(30) NOT NULL, --���¹�ȣ
    EMPLOYEE_STARTDAY DATE NOT NULL, --�Ի���
    EMPLOYEE_POSITION VARCHAR2(50) NOT NULL, --��å
    EMPLOYEE_PAY NUMBER NOT NULL--�ñ�/����
);
CREATE TABLE COMIC_EMP_ATTACH (
    UUID VARCHAR2(100) NOT NULL,
    UPLOADPATH VARCHAR2(200) NOT NULL,
    FILENAME VARCHAR2(100) NOT NULL,
    FILETYPE CHAR(1) DEFAULT 'I',
    EMPLOYEE_NUM NUMBER
);
select*from COMIC_EMP_ATTACH;
commit;
select*From comic_employee;

update comic_employee set employee_pay=8750;

commit;

select * from comic_employee order by employee_num;

	select roomuse_id,roomuse_num,roomuse_status,to_char(roomuse_starttime,'hh24:mi:ss')
		"starttime" from comic_roomuse;

-- �����޿�
drop table comic_pay;
CREATE TABLE COMIC_PAY (
--  PAY_NUM NUMBER, --�޿���ȣ
    PAY_WORKMONTH varchar2(30),--�ٹ� ��1910(�⵵,��)�̷������� ��
    PAY_EMP_NUM NUMBER, --������ȣ
    PAY_DATE  DATE, -- �޿�������
    PAY_TOTALTIME NUMBER, -- �����ð�(�ú��ʿ��� �÷�) 30���� �ݿø��ؼ� �ÿ� �߰��ϰ���
    CONSTRAINT COMIC_EMPLOYEE_NUM_FK FOREIGN KEY (PAY_EMP_NUM) 
    REFERENCES COMIC_EMPLOYEE (EMPLOYEE_NUM) ON DELETE CASCADE
);

select*from comic_pay;

commit;

create table tmpdate(
tmp_date date
);
select TO_CHAR(tmp_date, 'hh24:mi:ss')from tmpdate;

INSERT INTO tmpdate(tmp_date) VALUES ( TO_DATE('191123','YYMMDD'));
INSERT INTO tmpdate(tmp_date) VALUES ( TO_DATE('191123','YYMMDD'));
INSERT INTO tmpdate(tmp_date) VALUES ( TO_DATE('191123','YYMMdd'));
INSERT INTO tmpdate(tmp_date) VALUES ( TO_DATE('11-23-2012 10:26:11','MM-DD-YYYY HH24:MI:SS') );

-- ����� ���̺�
CREATE TABLE COMIC_WORKINGHOUR(
	WORKINGHOUR_EMP_NUM NUMBER, -- ������ȣ
	WORKINGHOUR_STARTTIME DATE, -- ��ٽð�
	WORKINGHOUR_ENDTIME DATE, -- ��ٽð�
    WORKINGHOUR_workday DATE, -- �����
	CONSTRAINT COMIC_EMPLOYEE_NUM_FK_2 FOREIGN KEY (WORKINGHOUR_EMP_NUM)
    REFERENCES COMIC_EMPLOYEE (EMPLOYEE_NUM) ON DELETE CASCADE
);

insert into comic_workinghour (workinghour_emp_num,workinghour_starttime,workinghour_workday) 
values(1001,sysdate,sysdate);

select*from comic_workinghour;

select*from comic_workinghour where workinghour_starttime='19/10/08';
select*from comic_workinghour where workinghour_starttime=sysdate;

SELECT * FROM comic_workinghour 
WHERE TO_CHAR(workinghour_workday, 'YYMMDD') = '191008' and workingHour_emp_num=1001;

SELECT TO_CHAR(workinghour_starttime, 'hh:mi:ss'),TO_CHAR(workinghour_ENDtime, 'hh:mi:ss')
FROM comic_workinghour 
WHERE TO_CHAR(workinghour_workday, 'YYMMDD') = '191008' and workingHour_emp_num=1001;

select*from comic_employee;

select TO_CHAR( workinghour_workday,'yyyymmdd')"workday"
	,TO_CHAR(workinghour_starttime, 'hh24:mi:ss')"starttime"
	,TO_CHAR(workinghour_ENDtime, 'hh24:mi:ss')"endtime"
	from comic_workinghour where workinghour_workday > '191001'
	and workinghour_workday < '191030' and workinghour_emp_num=1001;

select*from comic_employee where employee_num='1001';

update COMIC_EMPLOYEE set employee_name='����',employee_pwd=4500
	,employee_phone=1124
	,employee_account=010554,employee_position='����',
	employee_pay=450 where employee_num=1005;
    
    commit;





update comic_workinghour set workinghour_endtime=sysdate where workingHour_emp_num=1001;

select*from comic_workinghour ;

DELETE FROM comic_workinghour WHERE workingHour_emp_num=1001;

commit;


desc COMIC_WORKINGHOUR;

-- ��ǰ������̺�
CREATE TABLE COMIC_PRODUCTSTOCK (
	PRODUCT_NUM NUMBER PRIMARY KEY,  -- ��ǰ ��ȣ
	PRODUCT_NAME VARCHAR2(20) NOT NULL, -- ��ǰ�̸�
	PRODUCT_PRICE NUMBER NOT NULL, -- ��ǰ �ǸŰ�
	PRODUCT_QTY NUMBER NOT NULL, -- ��ǰ ����
	PRODUCT_CATEGORY VARCHAR2(20) NOT NULL -- ��ǰ ����
);

-- ��ǰ�������̺�
CREATE TABLE COMIC_PRODUCTORDER (
	PRODUCTORDER_NUM NUMBER,  -- ���ֹ�ȣ
	PRODUCTORDER_PRODUCT_NUM NUMBER,  -- ��ǰ��ȣ
	-- productorder_name varchar(20), -- ���ֻ�ǰ�̸�
	-- productorder_category varchar(20),  -- ���ֻ�ǰ����
	PRODUCTORDER_COST NUMBER, -- ���� ���Ű�
	PRODUCTORDER_QTY NUMBER,  -- ���� ����
	PRODUCT_DATE DATE, -- ���� ��¥
    CONSTRAINT COMIC_PRODUCTSTOCK_NUM_FK FOREIGN KEY (PRODUCTORDER_PRODUCT_NUM )  
    REFERENCES  COMIC_PRODUCTSTOCK (PRODUCT_NUM) ON DELETE CASCADE
);

-- å ���̺� (api Ȯ�� �ʿ� ����)
CREATE TABLE COMIC_BOOK (
    BOOK_NAME VARCHAR2(50),--å�̸�
    BOOK_LOC VARCHAR2(50),--å��ġ
    BOOK_PUBLISHER VARCHAR2(50),--å���ǻ�
    -- book_serialnumber varchar2(50)--å�ø����ȣ
    BOOK_WRITER VARCHAR2(20),  --å ����
    BOOK_CONTENT VARCHAR(500) , --å �Ұ�
    BOOK_CATEGORY VARCHAR(50), -- å �з�
    BOOK_LASTBOOK NUMBER, -- ��������
    BOOK_STATUS VARCHAR(20) -- �������
);

select*from comic_order;
-- �� ���̺�
CREATE TABLE COMIC_ROOM(
	ROOM_NUM NUMBER PRIMARY KEY, -- �� ��ȣ 
	ROOM_PRICE NUMBER NOT NULL, -- �� ��� 
	ROOM_PPL NUMBER NOT NULL -- �� �ο��� 
);

insert into comic_room values (7,200,6);

delete comic_room where room_num=7;

select *from comic_room;

-- �� ��� ���̺�
-- �� ��� off �� �ش� ���ڵ� ����
CREATE TABLE COMIC_ROOMUSE(
	ROOMUSE_ID VARCHAR2(20), -- �� ����� ���̵�
	ROOMUSE_NUM NUMBER, -- �� ��ȣ
	ROOMUSE_STARTTIME DATE, -- �� ���۽ð�
	ROOMUSE_ENDTIME DATE, -- �� ����ð�
	ROOMUSE_STATUS VARCHAR(5) DEFAULT 'off',  -- �� ������ on/off
    CONSTRAINT COMIC_ROOM_NUM_FK FOREIGN KEY (ROOMUSE_NUM)  
    REFERENCES COMIC_ROOM(ROOM_NUM) ON DELETE CASCADE--comic_room���̺��� (room_num)�� �����ɶ� ���⵵ ������ 
    
);

select*from COMIC_ROOMUSE;

insert into comic_roomuse (ROOMUSE_id,ROOMUSE_num,ROOMUSE_starttime,ROOMUSE_status)
values ('anonymous',7,sysdate,'on');

update comic_roomuse set roomuse_status='off' where roomuse_num=7;

update comic_roomuse set roomuse_status='on' where roomuse_num=7;

delete comic_roomuse where roomuse_num=7;

select*from comic_roomuse order by 2;

select roomuse_starttime from comic_roomuse;

select to_date('mi',roomuse_starttime) from comic_roomuse;

desc comic_roomuse;

commit;

delete comic_roomuse where roomuse_num=1;

select to_char(roomuse_starttime,'yyyy-mm-dd hh24:mi:ss') from comic_roomuse order by 1;

desc comic_roomuse;


select roomuse_id,roomuse_num,roomuse_status,to_char(roomuse_starttime,'hh24:mi:ss')
"starttime" from comic_roomuse;



-- �Ϻ� �ֹ� ���̺�(�ǽð�)
-- �� ���� �ʱ�ȭ
CREATE TABLE COMIC_ORDER(
	ORDER_NUM NUMBER , -- �ֹ� ��ȣ
	ORDER_ID VARCHAR2(20), -- �ֹ� ����� ���̵�
	ORDER_ROOMNUM  NUMBER,-- �ֹ� �� ��ȣ
	ORDER_TIME DATE, -- �ֹ� �ð�	
   	ORDER_PRODUCT_NUM NUMBER, -- ��ǰ ��ȣ
	ORDER_QTY NUMBER -- �ֹ� ����
);

SELECT*fROM COMIC_ORDER;

insert into comic_order (order_num,order_id,order_roomnum,order_time)values(
11,'tmehfld',2,sysdate);

insert into comic_order (order_num,order_id,order_roomnum,order_time)values(
11,'tmehfld',2,to_date(sysdate,'yyyy.mm.dd hh24:mi'));

insert into comic_order (order_num,order_id,order_roomnum,order_time)values(
11,'tmehfld',3,sysdate);

select order_id,to_char(order_time,'hh24:mi:ss')"���۽ð�" from comic_order where order_roomnum=3;
--dateŸ�Կ��� �ð��� �������� �޼���

select*from comic_order where order_roomnum=2;

SELECT TO_CHAR(SYSDATE, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�" FROM DUAL;

desc comic_order;

-- �������̺�(��ǰ,�� ���� ���̺�) �ΰ��� ������� �߾���!
-- ��ǰ ���� ���̺�
CREATE TABLE COMIC_PRODUCTSALES (
    PRODUCTSALES_ID VARCHAR2(20) NOT NULL, -- ����� ���̵�
    PRODUCTSALES_QTY NUMBER  NOT NULL, -- ����
    PRODUCTSALES_TIME DATE NOT NULL, -- �ð�(���� �Ǹ�)
    PRODUCTSALES_PRODUCT VARCHAR2(20) NOT NULL, -- ��ǰ 
    PRODUCTSALES_ORDER_PRICE NUMBER NOT NULL -- ���
); -- �ֹ� ��ǰ ���ڵ� �ϳ��� ��� ����


-- �� ���� ���̺�
CREATE TABLE COMIC_ROOMSALES(
	-- ���� å���� ...
	ROOMSALES_NUM NUMBER NOT NULL, -- ���ȣ
	ROOMSALES_TOTALPRICE NUMBER NOT NULL,-- ����
	ROOMSALES_TIME DATE NOT NULL-- �ð�
);


-- ä�� ���̺�
CREATE TABLE COMIC_CHAT (
	CHAT_NUM NUMBER,  -- ä�� ��ȣ 
	CHAT_ID VARCHAR(20),   -- ä�� ���̵� fk(�����)
	CHAT_TIME DATE,  -- ä�� �ð�
	CHAT_CONTENT VARCHAR(500)  -- ä�ó���
);

-- �ս����̺�
CREATE TABLE COMIC_LOSS (
    	LOSS_NUM NUMBER  DEFAULT 1, -- �ν� ��ȣ
	LOSS_CATEGORY VARCHAR(20), --�ν� ���� ����/����
	LOSS_QTY NUMBER, -- �ν� ����
	LOSS_PAY NUMBER, --�ν� ����,
	LOSS_PRODUCT VARCHAR(20), --�ν� ��ǰ
	LOSS_DATE DATE --�ν� ��¥
);


-- ��� ���̺�
CREATE TABLE COMIC_COMMENTS(
    CMNT_NUM NUMBER, -- ��۹�ȣ
    CMNT_BOARDNUM NUMBER, -- �۹�ȣ
    CMNT_CONTENT VARCHAR2(2000) NOT NULL,
    CMNT_ID VARCHAR2(30),
    CMNT_DATE DATE,
    CONSTRAINT CMNT_FK_ID FOREIGN KEY(CMNT_ID)
    REFERENCES COMIC_MEMBER(MEMBER_ID) ON DELETE CASCADE
);

-- �Խ��� ���̺�
CREATE TABLE COMIC_BOARD(
    BOARD_NUM NUMBER PRIMARY KEY,
    BOARD_ID VARCHAR2(30) NOT NULL,
    BOARD_CONTENT VARCHAR2(2000) NOT NULL,
    BOARD_DATE DATE,
    BOARD_TITLE VARCHAR2(50) NOT NULL,
    CONSTRAINT BOARD_FK_ID FOREIGN KEY(BOARD_ID)
    REFERENCES COMIC_MEMBER(MEMBER_ID) ON DELETE CASCADE	
);

--��ǰ�ֹ� �� ���̺�
CREATE TABLE COMIC_ORDERVIEW(
	ORDERVIEW_NUM NUMBER PRIMARY KEY,
ORDERVIEW_CATEGORY VARCHAR2(30) NOT NULL,
ORDERVIEW_PRODUCT_NUM NUMBER NOT NULL,

);


-- ��ǰ�������̺�
CREATE TABLE COMIC_ORDERVIEW_PRODUCT(
    ORDERVIEW_NUM NUMBER PRIMARY KEY,
	ORDERVIEW_PRODUCT_NUM NUMBER,
    CONSTRAINT COMIC_PRODUCTSTOCK_NUM_FK2 FOREIGN KEY (ORDERVIEW_PRODUCT_NUM)
    REFERENCES  COMIC_PRODUCTSTOCK (PRODUCT_NUM) ON DELETE CASCADE
);



insert into comic_productstock (product_num, product_name, product_price, product_qty, product_category)
values (1, 'ī���ī', 2200, 9999, 'Ŀ��');

insert into comic_productstock (product_num, product_name, product_price, product_qty, product_category)
values ((select max(product_num) from comic_productstock)+1, 'ī���ī', 2200, 9999, 'Ŀ��');

commit;