use nosql02

show collections

db.users.find()

// 논리연산문법
//$and : AND 조건문 -> a와 b를 둘다 키여야함.
//$or: or 조건문
//$not: NOT조건 => 반드시 조건 하나를 부정하는 경우에만 사용가능!
//$not + $or = $nor: OR +NOT


db.users.find(
  {$and:[{address: "서울시"}, {age: 25}]}
)

db.users.find(
  {address: "서울시"}, {age: 25}
)

//sql 방식
//  SELECT  * FROM user WHERE address = "서울"  AND age= 25;

db.users.find(
  {$or:[{address: "서울시"}, {age:45}]}
)

db.users.find(
  {age: {$eq:45}}
)
db.users.find(
  {age: {$not:{$eq:25}}}
)
 
db.users.find(
  {$not: [{address},{age:25}]}  // ==> 오류 $notdms 단일조건!!
)


db.users.find(
  {$nor: [{address: "경기도"}, {age: 45}]}
)

//mission: name이 Brown 이거나 age가 35인 데이터 조회 출력

db.user.find(
  {$or: [{name:"Brown"}, {age:{$eq:35}}]}
)
//$eq = 동치 및 동일함을 의미하는 연산, 거의 대부분 생략하는 경우 많음.
// 단일 연산 구문 안에서는 $eq 생략해도 거의 무방


db.users.find(
  {age: {$not:45}}  // 논리 연산자가 들어가는 순간 $eq이 생략되면 어떤 논리인지 인식하지 못해서 오류
)

db.users.find(
  {age: {$not:{$eq:45}}}
)
//$eq = 동치 및 동일함을 의미하는 연산, 거의 대부분 생략하는 경우 많음.


db.users.find(
  {age: {$ne:45}} // $ne는 not equal이라는 eq의 의미를 가지기 때문에 가능
)

// 정규표현식 = 특정 문자 내 원하는 문자열을 추출해서 가져오려고 할 때
//regular expression = re

// Da로 시작하는 문자열 추출
db.users.find({name: {$regex:/Da/}})
db.users.find({name: /Da/})

db.users.find({name: {$regex:/^Da/}})
// 캐럿 => 일반패턴: ~~으로 시작 //[^] => not





/* 정렬관련 문법
 SQL => ORDER BY ASC |DESC
 

//->d




*/
db.users.find(
  {address: "경기도"}
).sort({age: 1})
// 1은 오름차순 정렬, -1은 내림차순

// 문서갯수 카운트
db.users.find().count()
//SELECT COUNT(*) FROM USER


// 실제 해당 컬럼 내 존재하는 값만 찾아오겠다. 결측치의 값을 배제한다.
db.users.find(
  {address: {$exists:true}}
)

db.users.find(
  {address: {$exists:false}}
)

// 정석문법
db.users.find(
  {address: {$exists:true}}
).count()

//고전문법
db.users.count(
  {address: {$exists:true}}
)

//중복되는 값을 1번만 조회,출력
//SQL = DISTINCT
// 범주형 데이터(남,녀,10대 20대 등 그룹이 가능한 데이터) <-> 수치형

db.users.find()
db.users.distinct("address")
db.users.distinct("address", {age: {$gte:30}})

// SELECT COUNT(DISTINCT address) FROM users;
db.users.distinct("address").count() //====> error : count()는 find()이랑만 체인 가능
db.users.distinct("address").length  

// 전체 데이터를 조회하기에 너무 부담되는 경우, 리미트 함수
//SELECT * FROM users LIMIT 10;
db.users.find().limit(2)

db.users.find()
db.users.insertMany([
  {name: "유진", age: 25, hobbies: ["독서","영화", "요리"]},
  {name: "동현", age: 30, hobbies: ["축구","음악", "영화"]},
  {name: "혜진", age: 35, hobbies: ["요리","여행", "독서"]}
])
db.users.find()
// 단일값으로 구성된 경우 vs 배열형태를 띄고있는 경우
//$all : 모든 값이 촌재하는 경우
//$in => 여러값 가운데 1가지만이라도 존재한다면 찾아오는 것
//$nin => 여러개 값 중 어떤 값도 일치하지않는 데이터를 찾아옴

db.users.find({hobbies: {$all: ["축구", "음악"]}})  //두개를 다 가지고 있는 값
db.users.find({hobbies: {$in: ["축구", "음악"]}}) 
db.users.find({hobbies: {$nin: ["축구", "음악"]}}) 

//C: db.createCollection("")
//R: find, limit, count, distinct, $eq,$llt

//U:
//updateOne: 조건이 매칭되는 최초 데이터 1개만 변경
db.users.updateOne(
  {age: {$gt: 25}}, {$set:{address:"서울시"}}
)

//updateMany: 조건이 매칭되는 모든 데이터를 변경
db.users.updateMany(
  {age: {$gt: 25}}, {$set:{address:"서울시"}}
)

db.users.find({address: "서울시"})

db.users.updateMany(
  {address: "서울시"}, {$inc: {age: 3 }}
)


db.users.updateMany(
  {address: "서울시"}, {$inc: {age:-3 }}
)

// a가 40보다 큰 데이터의 address를 수원시로 바꾸기

db.users.updateMany(
  {age: {$gt:40}}, {$set: {address: "수원시"}}
)
 db.users.find(
   {address: "수원시"}
)
 
db.users.updateOne(
  {name: "유진"}, {$set: {age: 26}}
)

db.users.find({name: "동현2세"})

db.users.updateOne(
  {name: "동현"}, {$set: {name: "동현2세", age: 31}}
)
db.users.find({name: "동현2세"})

// $unset: 특정 컬럼의 값을 지우겟다는 것

db.users.updateOne(
  {name: "유진"}, 
  {$unset: {age: 1}}
)  // $unset: 특정 컬럼의 값을 지우겟다는 것

db.users.find({name: "유진"})

db.users.find()

// upsert: update +insert : 업데이트 대상을 먼저 찾고, 없으면 추가한다.


db.users.updateOne(
  {name: "민준"},
  {$set: {name: "민준", age: 22, hobbies: ["음악","여행"]}},
  {upsert : true}
)

//updateOne | updateMany 를 활용해서 기존값을 수정, 변경가능. (unnesting상태)
db.users.updateOne(
  {name: "유진"},
  {$push: {hobbies: "운동"}}  
)

db.users.find({name: "유진"})


// $set: overwirte (덮어쓰기 기능)
// $push: 내부적으로 값을 추가하는 기능 (배열 > 값을 추가할때)
//    => 추가하려고 하는 대상이 배열의 형태를 띄고있을때에만 가능

db.users.updateOne(
  {name: "유진"},
  {$pull: {hobbies: "운동"}}  
)
db.users.find({name: "유진"})

//C
//R
//U
//Delete

db.users.find()
db.users.deleteOne(
  {address:"서울시"}
)
db.users.deleteMany(
  {address: "서울시"}
)

db.users.drop()  // Collections 자체를 버려버림
db.users.deleteMany({}) // 안에는 날라가도 Collection 자체는 살아있음


//어떤 주제, 문제발견, 해결목표, 데이터 수집
// 패턴 및 규칙을 가지고 있는 형태의 데이터 : MySQL
// 일반적인 패턴과 규칙 X : MongoDB


//Python + MySQL 연결
//Python + MongoDB 연결


use ecommerce

db.teddyproducts.find()









