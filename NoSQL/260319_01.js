use nosql02
show collections

db.users.find()

//python -> crawling
// requests, selenium => SPA
// scrapy ->크롤링을 진행할때 수집해야하는 과정이 많아지면 코드 작성시, 오타& 오류 발생확률이 늘어남
//    => requests, selenium: 어느 부분이 잘못됐는지 확인, 디버깅이 어려움.
//    => 파이프 라인을 쪼갬 => 초기화, 수집, 순서, 저장결정, 형식

/*
  SQL vs NoSQL
  #빅데이터 #데이터입출력 #스키마
  
  MongoDB Aggregation Framework 문법
  NoSQL 문법을 통해 간단한 문서를 저장,조회,편집,삭지
  방대한 빅데이터 취급이 목적
  문서조회 -> 조건연산 -> 정렬 -> 출력
  위 단계들을 동시에 병렬적 작업이 가능하다
  => 해야할 작업을 그룹화, 파이프라인으로 연결 필요
*/








