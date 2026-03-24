use sample_mflix

show collections

db.movies.find(0).limit(3)
// _id : 영화별 고유 식별 id
// plot : 영화 줄거리 (요약)
// genres : 영화 장르 (배열)
// runtime : 영화 상영시간 (분)
// cast : 영화 출연 배우 (배열)
// num_mfilx_comments : 영화 댓글 갯수
// title : 영화 제목
// fullplot : 영화 줄거리 (장편)
// countries : 어떤 나라에서 제작 영화
// directors : 영화 감독
// rated : 영화관람 등급
// awards : 수상실적
// lastupdated : 가장 최근 업데이트가 된 날짜
// year : 개봉년도
// imdb : 영화별평점, 투표수, 고유 id
// type : 매체 타입 (영화, 드라마)


// 전통적 문법 방식
db.movies.find(
  {year:1995}
)

//aggregation 문법

//$match: 특정조건에 해당하는 값을 가져와라
db.movies.aggregate([
  {$match:{year:1995}}                        // {}가 하나의 파이프라인  $match: 특정조건에 해당하는 값을 가져와라
])

//$group : 특정 값을 기준으로 요소들을 그룹화하고자 할 때
//$project: 특정 그룹요소의 값을 수정.업데이트하고자 할 때
//$sum: 특정 그룹요소들의 전체 합계를 구하고자 할 때
//$avg: 특정 그룹요소들의 전체 평균을 구하고자 할 때
db.comments.find()
db.comments.aggregate([
  {$group : {
     _id: "$movie_id",
     commentCount: {$sum: 1}   
    }
  },
  {$project: {
      year: "$_id",
      commentCount: 1,
      _id: 0
    }
  }
])

//영화 연도별 평균 상영시간
db.movies.aggregate([
  {$group : {
    _id: "$year",
    runtime: {$avg: "$runtime"}
    }
    
  }
])

db.movies.aggregate([
  {$group : {
    _id: "$year",
    sumruntime: {$sum:1}
    } 
  }
])

db.movies.find().limit(10)
//sample_mflix > movies > imdb > 3 fields -> rating/votes/id
//일반적인 객체지향 프로그래밍언어 -> 부모 + 자식요소 : 온점 표기법
// ex) $imdb.rating

//연도별 개봉작들의 평균평점
db.movies.aggregate([
  {$group: {
    _id: "$year",
    averageRating: {$avg: "$imdb.rating"}
    }  
  }
])

db.movies.aggregate([
  {$group: 
    {
    _id: "$year",
    minRating: {$min: "$imdb.rating"},
    maxRating: {$max: "$imdb.rating"}
    }
  }
])

//$push: 찾아오려고하는 값들을 취합해서 하나의 배열안에 값을 추가하는 역할
db.movies.aggregate([
  { $group: {
    _id: "$year",
    titles: {$push: "$title"}
   }  
  }
])


//addToSet: 그룹핑 후 값을 취합할때, 중복값을 허용하지 않는 연산자.
//연도별 장르
db.movies.aggregate([
  {
    $group:{
      _id:"$year",
      genres: {$addToSet: "$genres"}
    }
  }
])

//$sort : 오름(1) 및 내림(-1)차순 정력 기능 
//       => $sort의 삽입순서는 공식처럼 정해져있지 않고 파이프라인을 생성하는 
//           연산자의 조합에 따라서 복수사용이 가능하며, 삽입순서도 유연하게 변경될 수 있음

//$first : 0~9a~z: 순서 중 최대한 첫번째를 찾을 때
//$last : 0~9a~z: 순서 중 최대한 마지막번째를 찾을 때
db.movies.aggregate([
  {
    $sort: {"year":1, "title": 1}
  },
  {
    $group: {
      _id: "$year",
      firstMovie: {$first: "$title"},
      lastMovie: {$last: "$title"}
    } 
  },
  {
    $sort: {"_id": 1} 
  },
])

//$avg: 평균값을 구하는 연산자
//strLenCP: 문자열의 길이를 구하는 연산자
//toString: 문자열로 형변환을 시켜주는 연산자
db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      avgTitleLength: {$avg:{$strLenCP: {$toString :"$title"}}}
    }
  },
  {
    $sort: {_id: 1}
  }
])

// $gte: greater than and equal: -이상
// $count: 특정조건 및 그룹화 요소들의 전체 갯수를 집계하는 연산자 
db.movies.aggregate([
  {
    $match: {year: {$gte:2000}}
  },
  {
    $count: "movies_since_2000"
  }
])

// $limit : 출력해서 보고자하는 값의 제한설정을 하려고 할 때
db.movies.aggregate([
  {
    $sort: {"year":1, "title":1}   // 오름차순 정렬인것
  },
  {
    $limit: 5
  }
])

// $unwind: 특정 배열 내 값을 개별적으로 풀어서 확인하고자 할 때 (unnest 기능)
db.movies.aggregate([
  {
    $unwind: "$genres" //장르의 갯수에 따라 행수가 추가됨
  },
  {
    $limit: 5
  }
])


db.movies.aggregate([
  {
    $match: {"imdb.rating": {$ne:""}}
  },
  {
    $sort: {"imdb.rating": -1}
  },
  {
    $limit: 3
  }
])

//mission: 2000년 이후로 개봉된 영화 수
db.movies.aggregate([
  {$match: {year: {$gte: 2000}}},
  {$count: {"total_movies"}}
])

// 각 연도별로 개봉된 영화수

db.movies.aggregate([
  {$group: {_id: "$year", count: {$sum: 1}}},
  {$sortL: {count: -1}},
])

// 각 연도별 평균 영화 러닝타임 조회

db.movies.aggregate([{
  {
    $group: {_id:"$year",avgRuntime: {$runtime}}}}])

// 러닝타임이 긴 영화를 찾아라
db.movies.aggregate([
  {$sort: {runtime: -1}},
  {$limit: 1}
])

db.movies.aggregate([
  {$group: {_id:null, maxRuntime: {$max: "$runtime"}}} //_id:는 그룹에서 필수인데 할 팔요가 없으면 null값을 넣어주면 됨
])


// 각 영화장르별 평균평점을 조회,출력
// 영화장르-> 장르개별
//[드라마,가족,액션] x
// 드라마: 평점, 가족: 평점 ㅇ

db.movies.aggregate([
  {$unwind : "$genres"  },
  {$group: {_id: "$genres", avgRating: {$avg: "$imdb.rating"}}},
  {$sort: {avgRating: -1}}
])
 
db.movies.find()

//각 연도별 가장 먼저 출시된 영화의 제목을 찾아라
db.movies.aggregate([
  {$sort: {"year":1, "released":1}},
  {$group: {_id: "$year", firstMovie:{$first: "$title"}}},
  {$sort: {_id: 1}}
])

db.movies.aggregate([
  {$unwind: "$genres"},
  {$group: {_id:"$year", uniqueGenres: {$addToSet: "$genres"}}},
  {$sort: {_id: 1}}
])







