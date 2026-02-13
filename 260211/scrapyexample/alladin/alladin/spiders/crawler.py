import scrapy
from scrapy import item


class CrawlerSpider(scrapy.Spider):
    name = "crawler"
    allowed_domains = ["alladin"]
    start_urls = ["https://www.aladin.co.kr/shop/wbrowse.aspx"]

    # def parse(self, response):
    #     menu = response.css("li#head_layer_menu_container > a.attr(href)").get()
    #     yield item

    # def _parse(self, response):
    #     category = response.css("div.categorysub_layer_new2 > ul > li > a.cate1::attr(href)").get()
    #     yield item

        
    def _parse(self, response):
        books = response.css("div.b-newbook > ul.b-booklist > li")

        for i, book in enumerate(books[:21,1]) :
             title = book.css("div.b-text > h4::text").get()
             author_company = book.css("div.b-author").get()
             price_point = book.css("div.b-price").get()
             url = book.css("div.b-text a.attr::(href)").get()

             item = AlladinItem()

             item["rank"] = i            
             item["title"]= title
             item["author_company"]= author_company
             item["price_point"]= price_point
             item["url"]= response.urljoin(link)

             yield item


