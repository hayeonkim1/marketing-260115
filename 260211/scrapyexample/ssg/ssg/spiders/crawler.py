import scrapy
import time
import csv
import re 

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys #enter 키 누루는 코드
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

from ssg.items import SsgItem


class CrawlerSpider(scrapy.Spider):
    name = "crawler"
    allowed_domains = ["www.ssg.com"]
    start_urls = ["https://www.ssg.com"]


    def __init__(self): 
        service = Service(ChromeDriverManager().install())
        options = Options()

        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--window-size=1920,1080")
        options.add_argument("--start-maximized")
        options.add_argument("--user-agent= Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 ")
        options.add_argument("--lang=ko_KR")
        options.add_argument("--no-sandbox")

        self.driver = webdriver.Chrome(service=service, options=options)
    
    def start_requests(self):
        url = "https://www.ssg.com/"
        yield scrapy.Request(url, callback=self.parse)


    def parse(self, response):
        try: 
            self.driver.get(response.url)
            time.sleep(3)

            ssgmall_tab = self.driver.find_element(By.XPATH, "//a[contains(@class, 'gnb_mall_link') and contains(text(),'신세계몰')]")
            ssgmall_tab.click()
            time.sleep(3)

            ssgspecial_tab = self.driver.find_element(By.XPATH, "//a[contains(@class, 'menu_lnk clickable') and contains(text(),'쓱-특가')]")
            ssgspecial_tab.click()
            time.sleep(3)

            food_button = self.driver.find_element(By.XPATH, "//button[@data-index='8']")
            food_button.click()
            time.sleep(3)

            results = list()
            seen_urls = set()

            def clean_txt(s) : 
                if not s : 
                    return ""
                s = re.sub(r"\s+", " ", s)
                return s.strip()

            while len(results) < 50 :
                elements = self.driver.find_elements(By.CSS_SELECTOR, "div.template-grid-item.css-8kawlz")
                added_this_round = 0
            for i, el in enumerate(elements) :
                try :
                    a = el.find_element(By.CSS_SELECTOR, "a[href]")
                    url = a.get_attribute("href")
                except :
                    continue
                    
                try :
                    name = el.find_element(By.CSS_SELECTOR, "p.chakra-text.css-19bfb2a").text.strip()
                except :
                    name = ""

                saleAndprice = el.find_element(By.CSS_SELECTOR, "div.chakra-stack.css-ffjhre")

                try:
                    discount = saleAndprice.find_element(By.CSS_SELECTOR,"em.css-aywnvu").text.strip()
                except :
                    discount = ""
                    
                try:
                    price = saleAndprice.find_element(By.CSS_SELECTOR,"em.css-1oiygnj").text.strip()
                except :
                    price = ""
   
                if url in seen_urls :
                     continue
                seen_urls.add(url)

                    
                results.append({"No": index+1, "상품명": name, "판매금액": price, "할인율": discount, "URL": url})
                added_this_round += 1

            if added_this_round == 0 :
                print("새 상품이 더이상 로드되지 않습니다.")
                break
                

           
        except Exception as e :
            self.logger.error(f"크롤링 에러 발생 : {e}", exc_info=True)
        finally:
             self.driver.quit()