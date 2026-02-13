# 인스타그램 사이트 크롤링 : 최초에 값을 가져올 때, 실수 -> 피곤!!!
# 은지 인스타그램 크롤링 : 완성되지 않은 상태로 크롤링 -> 사이트 방문 브라우저 (의심스러운 행위)
# 브라우저 & ip => 차단
# 미들웨어 : 가상브라우저 A -> 가상브라우저 B
# 주언어 한글 -> 영어

import random

class RandomUserAgentMiddleware:
    USER_AGENTS = [
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
    ]

    def process_request(self, request, spider) :
        request.headers.setdefault("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
        request.headers["User-Agent"] = random.choice(self.USER_AGENTS).encode("utf-8")
        return None