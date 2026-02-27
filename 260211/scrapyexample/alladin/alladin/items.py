

import scrapy


class AlladinItem(scrapy.Item):
    rank = scrapy.Field()
    title = scrapy.Field()
    author_company = scrapy.Field()
    price = scrapy.Field()
    point = scrapy.Field()
    url = scrapy.Field()
   
