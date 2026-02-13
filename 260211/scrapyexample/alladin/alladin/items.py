

import scrapy


class AlladinItem(scrapy.Item):
    title = scrapy.Field()
    author_company = scrapy.Field()
    price_point = scrapy.Field()
    url = scrapy.Field()
   
