db.getCollection("blog_posts").find({})


db.blog_posts.find(
  {},
  {
    _id: 0, //id는 가져오지 않겠다
    brand_name:1,
    title:1,
    link:1
  }
 )
 
db.blog_posts.countDocuments()  // 전체문서가 몇개의 행으로 되어있는지 보는 함수


db.blog_posts.find({
  brand_name:"아디다스"
})


// 타이틀에 특정 단어가 포함되어있는 문서
db.blog_posts.find({
  title: /골프화/  
})


// description에 특정 단어가 포함되어있는 문서
db.blog_posts.find({
  description: /여름/   
})

// 두개의 영역 중 특정 단어가 하나라도 발견되면 찾아와라
db.blog_posts.find({
  $or: [
    {title: /원피스/},
    {description: /여름/}
  ]
})

// 같은 영역 내에서 2개의 키워드중 하나라도 들어간 문서를 찾아라
db.blog_posts.find({
  $or: [
    {title: /원피스/},
    {title: /여름/}
  ]
})


// 정규표현식을 통한 표기
db.blog_posts.find({
    {title: /원피스|여름/},
})


db.blog_posts.find({
  brand_name: "룩캐스트",
  title : /원피스/
})

// []인 경우에만 찾아와라
db.blog_posts.find({
  brand_name: {
    $in: ["모노로우","레테라","아디다스"]  
  }
})

db.blog_posts.find({
  brand_name:{
    $ne:"파사드패턴"    //$ne: ~를 제외하고 찾아와라
  }
})


db.blog_posts.find().sort({
  collected_at:-1 //-1: 내림차순 정령, 1:오름차순 정렬
})


db.blog_posts.find().sort({
  postdate: -1 //-1: 내림차순 정령, 1:오름차순 정렬
})

db.blog_posts.find({
  postdate: {
    $gte: "20260423"  //$gte: 같거나 크다 (great than equal)
  }
})


db.blog_posts.findOne()


db.blog_posts.findOne({
  brand_name: "파사드패턴"
})


db.blog_posts.findOne({
  title: /여름/
})

db.blog_posts.find().sort({postdate:-1}).limit(5)
db.blog_post.find({
  brand_name:"아디다스"
})
.sort({postdate: -1}).limit(3)


db.blog_posts.find().sort({postdate:-1}).limit(5)
db.blog_post.find({
  brand_name:"아디다스"
})
.sort({postdate: -1})
.skip(1)  //n개를 건너뛰겠다
.limit(3)


db.blog_post.aggregate([
  {
    $group: {
      _id:"$brand_name",  //$: 각각 행마다의 값을 가져오기 위해
      blog_count:{$sum:1} //$sum:1 -> $sum 각행마다 연산을 실행한다
    }
  },
  {
    $sort: {blog_count: 1} //오름차순
  }
])

// 매칭되는 값들만 연산 실행
db.blog_posts.aggregate([
  {
    $match: {
      brand_name: "아디다스"
    }
  },
  {
    $group:{
      _id:"$brand_name",
      blog_count:{$sum :1}
    }
  }
])


db.blog_posts.aggregate([
  {
    $match: {
      brand_name: {
        $in: [  //$in : or의 역할
        "아디다스",
        "레테라",
        "파사드패턴"
        ]
      }
    }
  },
  {
    $group:{
      _id:"$brand_name",
      blog_count:{$sum :1}
    }
  }
])



db.blog_posts.aggregate([
  {
    $match: {
      title: /원피스/
    }
  },
  {
    $group: {
      _id: "$brand_name",
      summer_title_count: {$sum:1}
    }
  },
  {
    $sort: {summer_title_count:-1}
  }
])


// $project : 필요한 필드만 사용해 재취합 할때
db.blog_posts.aggregate([
  {
    $project: {
      _id:0,
      brand: "$brand_name",
      blog_title: "$title",
      date: "$postdate"
    }
  },
  {
    $limit:10
  }
])


db.blog_posts.aggregate([
  {
    $project: {
      _id: 0,
      brand_name:1,
      title:1,
      description_length: {$strLenCP: "description"} //$strLenCP: 행마다 문자열의 길이
    }
  },
  {
    $sort: {description_length:-1}
  }
])



db.blog_posts.aggregate([
  {
    $match: {
      $or: [
        {title: /여름|무더위/},
        {description:/여름|무더위/}
      ]
    }
  },
  {
    $project: {
      _id:0,
      brand_name:1,
      title: 1,
      description: 1,
      postdate: 1
    }
  },
  {
    $limit: 10
  }
])

db.collection.find().limit(5)




