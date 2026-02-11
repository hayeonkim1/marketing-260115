
import scrapy

#item 에서는 수집한 데이터를 어디에 넣을지 담당
class ScrapyProject01Item(scrapy.Item):
    title = scrapy.Field()
    description = scrapy.Field()
    
