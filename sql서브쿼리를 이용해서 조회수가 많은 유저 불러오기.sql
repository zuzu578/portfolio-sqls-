/*조회수가 가장많은 유저를 셀렉트 (서브 쿼리 ) */
select userid,nClick from board where nClick = (select max(nClick) from board);