<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$(function() {
		$('#b1').click(function() {
			
			$.ajax({
				url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerStatus',
				data: {
					serviceKey: 'zutr%2B3KJ%2FEBSrJ4x%2FHLtr37BE2%2FzH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP%2F89PRB4WJG36p%2BcZg%3D%3D',
					statId: ''
				},
				dataType: 'json',
				success: function(json) {
					console.log(json)
					box_list = json.boxOfficeResult.dailyBoxOfficeList
					$('#result').empty()
					
					for(let i = 0; i < box_list.length; i++) {
						let rank = box_list[i].rank
						let movieCd = box_list[i].movieCd
						let movieNm = box_list[i].movieNm
						let scrnCnt = box_list[i].scrnCnt
						let openDt = box_list[i].openDt
						
						/*
						location.href = 'movie?rank=' + rank
								+ '&movieCd=' + movieCd
								+ '&movieNm=' + movieNm
								+ '&scrnCnt=' + scrnCnt
								+ '&openDt=' + openDt
						*/
						
						$.ajax({
							url: "movie",
							data: {
								rank: rank,
								movieCd: movieCd,
								movieNm: movieNm,
								scrnCnt: scrnCnt,
								openDt: openDt
							},
							success: function(result) {
								console.log(result)
							}
						})
					}
				}
			})
		})
	})
</script>

</head>
<body>

<div>
	<!-- 헤더 삽입 위치 -->
</div>

<div>
	<div><!-- 충전소 명칭 --></div>
	<div><!-- 충전소 정보(충전타입, 충전속도) --></div>
	<div>
		<!-- 개별충전기 목록 -->
		<!-- table? -->
		<!-- api를 통해서 충전기 사용가능여부 불러오기 -->
		
		
	</div>
	
</div>

</body>
</html>