

from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem


# david에게 받아온 값들을 정제해서 다시 덮어씌우기
class CleanCategoryPipline :  
    def process_item(self, item, spider):
        item["category"] = item["category"].strip()
        return item

#중복값을 허용하지 않는 set를 활용하는 클래스 선언
class SetPipline :
    def __init__(self) : #받아오는 값이 중복하는 지 검증하기 위해 초기값을 만들어줘야함 -> init
        self.categories_seen = set() #중복값은 들어오지 못하는 set으로 새로운 방을 지정

    def process_item(self, item, spider) : 
        if item["category"] in self.categories_seen : 
            raise DropItem("Duplicate item found: %s" % item)
        else : 
            self.categories_seen.add(item["category"])
            return item 

#"관련 상품 추천" 이라는 공통 구문 삭제하는 파이프라인 만들기
class RemovePhrasePipline : 
    def process_item(self, item, spider) :
        item["category"] = item["category"].replace("관련 상품 추천", "")
        return item

#파이프라인 순서정하기 => settings 에서!