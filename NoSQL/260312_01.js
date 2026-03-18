// 현재 나의 계정 속 데이터 베이스 조회
show dbs

// 특정 데이터 베이스를 선택.사용
use datamkt
use admin
use nosql02

// 쿼리문 실행
// ctrl+enter | ctrl + shirft+ enter

// 현재 데이터베이스 안에 컬렉션 조회
show collections

// 현재 데이터베이스 안에 특정 컬렉션안에 데이터 찾기
// 객체지향 프로그래밍 언어의 경우 , 부모루트 > 자녀루드로 이동
db.test.find() 
// 데이터베이스 상태정보 확인 
db.stats()

//데이터베스 안에 컬렉션을 삭제
db.test.drop()
//데이터베이스 자체를 삭제
db.dropDatabase()

//계정 내 특정 데이터베이스 사용
use nosql02

// 특정 데이터 베이스 안에서 컬렉션 생성
db.createCollection("test")
// db.test.drop() = db.dropDatabase()

db.createCollection("log", {
    capped : true, size:5242880, max:5000  // 사이즈의 단위: 1바이트 = 8비트 / 1킬로바이트(KB), 
})

// 데이터 베이스 > 컬렉션 조회
show collections

// 현재 컬랙션이 capped옵션설정 여부 조회
db.log.isCapped()
db.test.isCaapped()

// 컬렉션 이름 변경
db.log.renameCollection("test02")


/* 
Nosql에서 사용할 수 있는 type:
String : 문자열 = "david"
Integer: 정수 = 양으정수, 음의정수 =32비트/64비트
Boolean: 논리형 = true, false
Double : 부동소수점을 가지고 있는 데이터타입 = 4.5 3.8 0.3
Arrays : 배열 ["a",:"b","c"] -> list 느낌
Object : 객체 {city : "Seoul"} -> 딕셔너리 느낌
Null : 비어있는 NULL이라는 값을 정의하기 위한 타입 = 결측치
objectID : primary key 느낌 -> 문서를 식별할 수 있도록 해주는 ID
Date : 날짜 데이터를 정의할 수 있는 타입
*/

// NoSQL 기반, CRUD :  Create , Read ,Update, delete
use nosql02
db.createCollection("users")

// 생성된 컬렉션에 값을 1개씩 입력하고자 할 때
db.users.insertOne(
  {subject: "mongodb", author: "david", views: 50}
)

// 입력된 값을 조회하고자 할 때
db.users.find()

// 생성된 컬렉션에 여러개의 값을 동시에 삽입하고자 할때
db.users.insertMany(
  [
   {subject: "coffee", author: "xyz", views: 50},
   {subject: "Coffee Shopping", author: "dfg", views: 100},
   {subject: "Baking a cake", author: "abc", views: 5},
   {subject: "baking", author: "sddsf", views: 9},
   {subject: "godgod", author: "weef", views: 200},
   {subject: "cafe in", author: "zde", views: 50},
   {subject: "cup of tea", author: "joe", views: 675},
   {subject: "mongodb", author: "david", views: 64}
  ]
)

db.users.find()

db.users.drop()

db.createCollection("users" , {
  capped : true, size: 5242880, max:5000
})
db.users.find()
db.stats()

db.users.insertMany(
  [
  {name: "David", age:25, address: "서울시"},
  {name: "Dave", age:45, address: "경기도"},
  {name: "Andy", age:50, hobby: "골프", address: "경기도"},
  {name: "Kate", age:35, address: "수원시"},
  {name: "Brown", age:6}
  ]
)

// 최초에 스키마 설정 시, name, age, address= not null => SQL이었으면 오류가 났을 것. 
//But,NoSQl은 스키마 설정을 안하기 때문에 다 받아올 수 있음
 
// SELECT * FROM users;     ---> mysql
db.users.find()
// SELECT _id, name, address FROM users;
db.users.find({}, {name: 1, address:1})  // 조건은 없지만 선별한다  -> id는 기본으로 붙음.
// SELECT name, address FROM users;
db.users.find({}, {name: 1, address:1, _id: 0}) 
//SELECT * FROM users WHERE address = "서울시"
db.users.find({address: "서울시"})
  // => find() 안의 첫번째값이 where 조건절이 된다


//SELECT name, address FROM users WHERE address = "서울시"
db.users.find({address: "서울시"},{name: 1,address:1, _id=0})

db.users.find()
db.users.find(
 {name:"Dave"},
 {name:1, age:1, address:1}
)

// 비교연산자를 활용한 조회
db.users.find(
  {age: {$gt:25}}  // $gt: 초과하는 값
)

db.users.find(
  {age: {$lt:25}}  // $lt: 미만인 값
)
db.users.find(
  {age: {$lt:25, $lte:50 }}  // $lt: 미만인 값 $lte: 이하
)
// , => 논리연산자 and를 뜻함

db.users.find(
  {age: {$gt:25, $lte:50 }}
 )
// SELECT * FROM users WHERE age > 25 AND age <=50;


// SELECT * FROM users WHERE age IN (45,50) => age가 45 또는 50인 값  =>##[]는 또는이라는 뜻
db.users.find(
  {age: {$in: [45,50]}}
)


// SELECT * FROM users WHERE age <> 25 => 25세가 아닌 값을 찾아라
db.users.find(
  {age: {$ne: 25}}
)


/* 비교연산자 문법
$gt : 초과 >
$gte: 이상 >=
$lt: 미만 <
$lte: 이하 <=
$eq: 같음 =
$ne: 다름 != <>
$in: 또는 
$or: 또는
*/
// , => 논리연산자 and를 뜻함

// SELECT * FROM users WHERE age IN (45,50) => age가 45 또는 50인 값
db.users.find(
  {age: {$eq: 45 , $eq:50}}   // => ,는 and 연산자 45이면서 50인 숫자는 없음
) 
// BUT 오류 안뜸
// NoSQL 장&단점 : 문법이 너무 유연하다보니 무엇이 에러인지 조차 알기 어려울때가 있음

db.users.find(
  {
    $or: [
      {age: {$eq:45}},
      {age: {$eq:50}}
    ]
  }   
) 

// SELECT * FROM users WHERE age Not IN (25) =>25세가 아닌 복수의 값을 찾아와라
db.users.find(
  {age: {$nin:[25]}} 
)
      // => []는 복수의 값이 들어갈수 있음 다수의 값을 또는으로 비교가능
db.users.find(
  {age: {$ne:25}}
)
     // => 단일값 비교

db.users.find(
  {age: {$ne:25, $ne: 45}}   // XXX 틀린문법. but 오류가 발생하지 않음.
)

// -----------------------------------------------------------

//문제1: age가 20보다 큰 name만 출력
db.users.find(
  {age: {$gt:20}},{name:1}
)


//문제2: age가 50이고 address가 경기도인 값의 name만
db.users.find(
  {age: {$eq:50} , address: "경기도"}, {name:1, _id:0}
)

//3: age가 30보다 작은 name과 age출력 

db.users.find(
  {age: {$lt:30}}, {name:1, age:1, _id:0}
)












