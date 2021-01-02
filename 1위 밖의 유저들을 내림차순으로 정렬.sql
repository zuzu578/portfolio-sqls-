<!-- 1위 외의 순위 리스트 불러오기  -->
	<!-- 조회수를 기준으로 내림차순 정렬  -->
	<select id="UserRanking" resultType="com.exhibition.project.BoardDto.BoardDto">
	select distinct(userid),nclick,rdate from board where nclick >=150 order by nclick desc
	
	</select>