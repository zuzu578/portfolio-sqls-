create table board(
 board_num number(4) primary key,
 userid varchar2(500),
 boardtopic varchar2(80),
 board_comment varchar2(999),
 rdate date default sysdate,
  nClick number(4) default 0,
   bGroup number(4),
    bStep Number(4),
    bIndent Number(4)
  
 
);