# 정제처리 단계

from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem

class BrunchsitePipeline:
    def process_item(self, item, spider):
        # a = ItemAdapter(item)

        title = (item.get("title") or "").strip()
        rank = item.get("rank")

        if not title :
            raise DropItem("Missing title")

        item["title"] = title
        item["rank"] = rank

        return item
