

//aggregation framework

// $project: 기존 데이터에서 필드명을 수정 및 변경하거나, 새로운 필드를 생성, 특정필드만 취합해서 가져올 때 사용
//-> id: $porject 연산자를 사용할 때 기본값으로 항상 따라다님
db.movies.aggregate([
  {$project: {_id:0, title:1, year:1}},
  {$limit:5}
])
// 결과값으로 나타내고자 하는 특정 필드는 1을 넣어줘야함. 
// But _id의 경우는 기본값이기 때문에 안보고 싶으면  _id :0을 해줘야함

// $concat : 특정 문자열 필드들을 연결해서 새로운 문자열을 생성할 때 사용
db.movies.aggregate([
  {
    $project: {
      _id: 0, title: 1, year:1, releasedIn: {$concat: ["$title"," (", {$toString:"$year"},")"]}
      }
   },
  {$limit: 10},
  {$sort: {year:1}}
])

// $lookup : NoSQL 기반 JOIN의 느낌
// 서로다른 컬렉션의 값을 연결시켜주는 기능

db.comments.find().limit(10) //#movie_id
db.movies.find().limit(10)// #_id

// left outer join의 느낌
//  -> table+ table  -> 왼족에 존재하는데 오른쪽에는 존재하지 않는 값이 있다면 null값처리
db.comments.aggregate([
  {
    $lookup: 
      {
        from: "movies",
        localField: "movie_id",   // localField: 왼쪽 컬렉션에서 가져올 컬럼
        foreignField:"_id",       // foreignField: 오른쪽 컬렉션에서 가져올 컬럼
        as: "movie"               // 합친 컬렉션명
        }              
   }
])

//
db.comments.aggregate([
  {
    $lookup: 
      {
        from: "movies",
        localField: "movie_id",   // localField: 왼쪽 컬렉션에서 가져올 컬럼
        foreignField:"_id",       // foreignField: 오른쪽 컬렉션에서 가져올 컬럼
        as: "movie"               // 합친 컬렉션명
        }              
   },
   {$match: {movie: {$ne: []}}}   // inner join처럼 만들기
])


db.users.find().limit(10) //#email
db.comments.find().limit(10)//#email

db.users.aggregate([
  {
    $lookup:{
      from:"comments",
      localField: "email",
      foreignField: "email",
      as: "user_comments"
    }}
])

// $limit(n) : 몇개까지 데이터문서를 보여줄 것인가?
// $skip(n) : 몇개까지 건너뛴 상태로 데이터문서를 보여줄 것인가?

db.movies.aggregate([
  {$skip: 2},
  {$limit: 10},
  {$sort: {year: 1}}
  
])

db.movies.aggregate([
  {$match:{runtime: {$gte:100}}},
  {$sort: {runtime :-1}},
  {$skip: 2}
])

// $facet : 파이프라인의 진행과정을 최대한 비동기형태의 느낌으로 실행할 수 있도록 하기위한 목적
// 복수의 상이한 업무를 병렬방식으로 진행하고자 할 때, 사용하는 문법
db.movies.aggregate([
  {$facet: {
    movieCountByYear: [
      {$group: {_id: "$year", count: {$sum: 1}}}
    ],
    maxRatingByYear: [
      {$group: {_id: "$year", maxRating: {$max: "$imdb.rating"}}}
    ]
  }}
])

// $redact : 데이터 문서상에서 어떤 조건 혹은 규칙에 따라 무언가를 실행!!
// 기존 연산자들은 $ -> 1번만 사용, 시스템변수: aggregation 프레임 워크문
// KEEP, PRUNE -> MongoDB가 기존에 가지고 있는 기본 문법 체계안에 있는 
db.movies.aggregate([
  {
    $redact: {
      $cond: {
        if: {$gte: ["$imdb.rating", 7]},
        then: "$$KEEP",
        else: "$$PRUNE"
      }
    }
  }
])
