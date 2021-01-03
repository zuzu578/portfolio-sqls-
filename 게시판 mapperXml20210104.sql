<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC " -//mybatis.org//DTD Mapper 3.0//EN" 
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.exhibition.project.BoardDao.BoardDao">
<!-- 댓글 달기 -->
	<select id="contentView" resultType="com.exhibition.project.BoardDto.BoardDto">
	<!-- 클릭한 게시물 목록 가져오기 -->
	select board_num,userid,boardtopic,board_comment,rdate,nClick,bGroup,bStep,bIndent
		 from board where board_num =#{param1}
	
	
	</select>
	<!-- 조회수 오름차순 정렬  -->
	<select id="ViewDescList" resultType="com.exhibition.project.BoardDto.BoardDto">
	select board_num,userid,boardtopic,board_comment,rdate,nClick,bGroup,bStep,bIndent
		 from board order by nclick desc
	
	</select>
	<!--  조회수 내림차순 정렬 -->
	<select id="ViewAscList" resultType="com.exhibition.project.BoardDto.BoardDto">
	select board_num,userid,boardtopic,board_comment,rdate,nClick,bGroup,bStep,bIndent
		 from board order by nclick asc
	</select>
	<!-- 최근 게시물 보기 -->
	<select id="ViewDateDsc" resultType="com.exhibition.project.BoardDto.BoardDto">
		select board_num,userid,boardtopic,board_comment,rdate,nClick,bGroup,bStep,bIndent
		 from board order by rdate desc
	</select>
	<!--  오래된 게시물 보기  -->
	<select id="ViewDateAsc" resultType="com.exhibition.project.BoardDto.BoardDto">
	select board_num,userid,boardtopic,board_comment,rdate,nClick,bGroup,bStep,bIndent
		 from board order by rdate asc
	
	</select>
	
	
	<select id="memberCheck" resultType="int">
	select count(*) cnt from board where userid=#{param1}
	
	
	</select>
	<!-- 제목을 검색할때 그 제목을 기준으로 게시물 검색 -->
	<select id="SearchBoard" resultType="com.exhibition.project.BoardDto.BoardDto">
	select board_num,userid,boardtopic,rdate,nClick from board where boardtopic like '%' ||  #{param1} || '%' order by rdate desc


	
	</select>
	<!-- 최근 활동 구하기 -->
	<select id="userDate" resultType="String">
	select MAX(rdate)from board where userid=#{param1}
	
	</select>
	<!-- report -->
	<select id="board_report" resultType="com.exhibition.project.BoardDto.BoardDto">
	select userid,boardtopic,board_comment from board where board_num =#{param1}
	
	</select>
	
	<insert id="try_report">
	insert into report(userid,boardtitle,board_comment,report_comment) 
	values(#{param1},#{param2},#{param3},#{param4})
	
	</insert>
	<!-- 유저 랭킹 구하기 (게시물 조회수가 많은 유저 구하기==> 서브쿼리)-->
	<select id="firstRanking" resultType="String">
	select userid from board where nClick = (select max(nClick) from board)
	
	</select>
	<!-- 게시물 조회수 가많은 유저 의 게시물 조회수 구하기 -->
	<select id="firstRankingNclick" resultType="String">
	select nClick from board where nClick = (select max(nClick) from board)
	
	
	</select>
	<!-- 1위 외의 순위 리스트 불러오기  -->
	<!-- 조회수를 기준으로 내림차순 정렬 + 그조회수에 해당하는 유저가 쓴 글의 제목을 가져오기 -->
	<select id="UserRanking" resultType="com.exhibition.project.BoardDto.BoardDto">
	select distinct(userid),board_num,nclick,rdate,boardtopic from board where nclick >=150 order by nclick desc
	
	</select>
	<!-- 유저수 구하기 ==>중복되는 값은 distinct를 이용해서 제거  -->
	<select id="UserCount" resultType="int">
	select count(distinct(userid))from board
	</select>
	
	<select id="RankingCount" resultType="String">
	select  count(*) cnt from board where userid=#{param1}
	
	</select>
	<insert id="reply">
	insert into board(board_num,userid,boardtopic,board_comment,bGroup,bStep,bIndent) 
	values(board_seq.nextval,#{param1},#{param2},#{param3},#{param4},#{param5},#{param6})
	
	</insert>
	<update id="replyShape">
		update board set bStep=bStep+1 where bGroup=#{param1} and bStep > #{param2}
	
	</update>
	
	
	<select id="list" resultType="com.exhibition.project.BoardDto.BoardDto">
	
		select board_num,userid,boardtopic,rdate,nClick,board_comment
		from board order by rdate desc 
	</select>
	
	<select id="previous" resultType="com.exhibition.project.BoardDto.BoardDto">
	
	select board_num,
        userid,
        boardtopic,
        rdate,
        nclick,
        board_comment
        from(select board_num,
        userid,
        boardtopic,
        rdate,
        nclick,
        board_comment,
        row_number()over(order by board_num desc) as rnum 
        from board
            )
            where rnum between 1 and 10 
            order by board_num desc
	</select>
	
	
	<!-- 클릭한 게시물 목록 가져오기 -->
		<select id="board_view" resultType="com.exhibition.project.BoardDto.BoardDto">
	select board_num,userid,boardtopic,rdate,nClick,board_comment,bGroup,bStep,bIndent
		 from board where board_num =#{param1}
	
	
	</select>
	 
	<select id="findUser" resultType="com.exhibition.project.BoardDto.BoardDto">
	select userid from board where userid=#{param1}
	
	
	</select>
	<select id="userCount" resultType="int">
	
		select count(*) cnt from board where userid=#{param1}
	
	</select>
	<select id="userlist" resultType="com.exhibition.project.BoardDto.BoardDto">
	
	select board_num,userid,boardtopic,rdate,nClick,board_comment
		from board where userid=#{param1}
	</select>
	
	<update id="Doboard_update">
	update board set userid=#{param2},boardtopic=#{param3},board_comment=#{param4} where board_num=#{param1}
	
	</update>
	<update id="upHit">
	
	update board set nClick=nClick+1 where board_num=#{param1}
	</update>
	
	<insert id="write">
	insert into board(board_num,boardtopic,userid,nClick,board_comment)
	values(board_seq.nextval,#{param1},#{param2},'0',#{param3})                                        
	</insert>
	<delete id="Doboard_delete">
	delete from board where board_num=#{param1}
	
	</delete>
</mapper>