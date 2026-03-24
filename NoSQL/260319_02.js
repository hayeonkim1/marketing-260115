use sample_mfilx

show collections

db.movies.find().limit(3)
// _id : 영화별 고유 식별 id
// plot : 영화별 줄거리
// genres : 영화 장르(배열)
// runtime : 영화 상영시간 (분)
// cast : 영화 출연배우 
// num_mfilx_comments : 영화 댓글 갯수
// title : 양화제목
// fullplot : 영화 줄거리 (장편)
// country : 어떤 나라에서 제작한 영화인가
// directors : 영화 감독
// rated : 영화 관람 등급
// awards :  수상실적
// lastupdated : 가장 최근 업데이트가 된 날짜
// year : 개봉년도
// imdb : 영화별 평점, 투표수, 고유 아이디
// type : 매체 타입(영화, 드라마)