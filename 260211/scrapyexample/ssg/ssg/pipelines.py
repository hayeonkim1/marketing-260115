
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem

class SsgPipeline:
    def process_item(self, item, spider):
        a = ItemAdapter

        rank = a.get("rank")
        name = (a.get("name")).strip()
        price = (a.get("price")).strip()
        discount = (a.get("discount")).strip()
        url = (a.get("url")).strip()

        if not 

        return item
