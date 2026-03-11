import scrapy
from alladin.items import AlladinItem


class CrawlerSpider(scrapy.Spider):
    name = "crawler"
    allowed_domains = ["alladin"]
    start_urls = ["https://www.aladin.co.kr/shop/wbrowse.aspx?CID=336&start=we_header"]

    def parse(self, response):
        books = response.css("div.b-newbook > ul.b-booklist > li")

        for i, book in enumerate(books[:20]) :
             title = book.css("div.b-text > h4 > a::text").get().strip()
             author_company = book.css("div.b-author::text").get().strip()
             price = book.css("div.b-price > strong::text").get().strip()
             point = book.css("div.b-price::text").get().strip().split("/")[1]
             url = book.css("div.b-text a::attr(href)").get().strip()

             item = AlladinItem()

             item["rank"] = i            
             item["title"]= title
             item["author_company"]= author_company
             item["price"]= price
             item["point"]= point
             item["url"]= response.urljoin(url)

             yield item


