
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem


class CleanValidatePipeline:
    def process_item(self, item, spider):
        a = ItemAdapter(item)
        # title = item.get("title").strip()
        title = a.get("title").strip()
        author_company = a.get("author_company").strip()
        price_point = a.get("price_point").strip()
        url = a.get("url").strip()

        if not title:
            raise DropItem("Missing title")
        if not url:
            raise DropItem("Missing url")
        if not author_company:
            raise DropItem("Missing author_company")
        if not price_point:
            raise DropItem("Missing price_point")

        item["title"] = title
        item["url"] = url
        item["author_company"] = author_company
        item["price_point"] = price_point

        return item





        return item
