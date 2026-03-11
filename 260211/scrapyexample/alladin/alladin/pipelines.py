
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem


class CleanValidatePipeline:
    def process_item(self, item, spider):
        a = ItemAdapter(item)
        # title = item.get("title").strip()
        title = a.get("title").strip()
        author_company = a.get("author_company").strip()
        price = a.get("price").strip()
        point = a.get("point").strip()
        url = a.get("url")

        if not title:
            raise DropItem("Missing title")
        if not url:
            raise DropItem("Missing url")
        if not author_company:
            raise DropItem("Missing author_company")
        if not point:
            raise DropItem("Missing point")
        if not point:
            raise DropItem("Missing point")

        item["title"] = title
        item["url"] = url
        item["author_company"] = author_company
        item["price"] = price
        item["point"] = point


        return item
