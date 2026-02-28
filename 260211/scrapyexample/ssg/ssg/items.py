

import scrapy


class SsgItem(scrapy.Item):
    rank = scrapy.Field()
    name = scrapy.Field()
    price = scrapy.Field()
    discount = scrapy.Field()
    url = scrapy.Field()

 
