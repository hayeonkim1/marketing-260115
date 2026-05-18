(() => {
  const state = {
    activeScreen: "main",
    history: [],
    currentDetailIndex: 1,
    coupon: {
      cream: false,
      dosirak: false,
      dessert: false,
      drink: false,
      ramen: false,
    },
    popup: { dosirak: false, dessert: false, drink: false, ramen: false },
    cartItems: [],
    activeCartCouponIndex: null,
    listTimer: null,
  };

  const productNames = {
    1: "혜자)통오겹김치찜도시락",
    2: "삼각)전주비빔삼각",
    3: "오뚜기컵누들매콤",
    4: "한끼)백년한우도시락",
    5: "연세)우유생크림빵",
    6: "짜투)잠봉치즈롤부르끼",
    7: "연세)블루베리생크림빵",
    8: "밀키스340ml",
    9: "del)돌체콜라겐라떼500",
    10: "롯데)밀키스캔250ml",
    11: "칸타타)아메캔200ml",
    12: "롯데)솔의눈캔240ml",
    13: "한끼)백년한우소불고기",
    14: "하림)치킨왕라면",
    15: "쫀득)피넛버터쿠키",
    16: "농심)신라면골드봉지",
  };

  const categoryByIndex = (idx) => {
    if (idx <= 4) return "dosirak";
    if (idx <= 8) return "dessert";
    if (idx <= 12) return "drink";
    return "ramen";
  };

  const prices = {
    1: 1800,
    2: 1400,
    3: 3200,
    4: 5700,
    5: 2800,
    6: 3500,
    7: 4000,
    8: 1900,
    9: 1800,
    10: 1500,
    11: 1500,
    12: 1300,
    13: 3900,
    14: 1800,
    15: 3500,
    16: 1500,
  };

  const popupTexts = {
    cart: ["장바구니에 담겼습니다.", "장바구니 탭에서 확인해 보세요"],
    issued: ["쿠폰이 발급되었습니다.", "쿠폰함 탭에서 확인해 보세요"],
    cream: [
      "고객님께 쿠폰이 발급되었습니다!",
      "[4월 꿀할인] 황치즈생크림빵 20% 할인",
    ],
    dosirak: [
      "고객님께 쿠폰이 발급되었습니다!",
      "[4월 꿀할인] 도시락/김밥 20% 할인",
    ],
    dessert: [
      "고객님께 쿠폰이 발급되었습니다!",
      "[4월 꿀할인] 디저트/빵 20% 할인",
    ],
    drink: ["고객님께 쿠폰이 발급되었습니다!", "[4월 꿀할인] 음료 10% 할인"],
    ramen: [
      "고객님께 쿠폰이 발급되었습니다!",
      "[4월 꿀할인] 라면/간편식 10% 할인",
    ],
  };

  function setScreen(name) {
    if (state.activeScreen !== name) state.history.push(state.activeScreen);
    state.activeScreen = name;
    document
      .querySelectorAll(".screen")
      .forEach((el) => el.classList.remove("active"));
    document.getElementById(`screen-${name}`)?.classList.add("active");
    renderLayers();
    handleListTimeoutFlow();
    window.scrollTo({ top: 0, behavior: "auto" });
  }

  function goBack() {
    const prev = state.history.pop();
    if (!prev) return;
    state.activeScreen = prev;
    document
      .querySelectorAll(".screen")
      .forEach((el) => el.classList.remove("active"));
    document.getElementById(`screen-${prev}`)?.classList.add("active");
    renderLayers();
    handleListTimeoutFlow();
  }

  function openPopup(kind, autoMs = 2000) {
    const layer = document.getElementById("popup-layer");
    if (!layer) return;
    const txt = popupTexts[kind] || ["안내", ""];
    const moveInTop = kind === "drink" ? " move-in-top" : "";
    layer.innerHTML = `
      <div class="popup-box${moveInTop}">
        <strong>${txt[0]}</strong>
        <div>${txt[1]}</div>
      </div>
    `;
    layer.classList.add("open");
    if (autoMs > 0) {
      setTimeout(() => {
        layer.classList.remove("open");
      }, autoMs);
    }
  }

  function handleListTimeoutFlow() {
    if (state.listTimer) {
      clearTimeout(state.listTimer);
      state.listTimer = null;
    }
    if (state.activeScreen !== "list") return;
    state.listTimer = setTimeout(() => {
      if (state.popup.dosirak) {
        openPopup("dosirak", 2000);
        state.popup.dosirak = false;
      } else if (state.popup.dessert) {
        openPopup("dessert", 2000);
        state.popup.dessert = false;
      } else if (state.popup.drink) {
        openPopup("drink", 2000);
        state.popup.drink = false;
      } else if (state.popup.ramen) {
        openPopup("ramen", 2000);
        state.popup.ramen = false;
      }
    }, 3000);
  }

  function issueCategoryCoupon(cat) {
    state.coupon[cat] = true;
    state.popup[cat] = true;
  }

  function onDetailBuy() {
    const idx = state.currentDetailIndex;
    state.cartItems.push({
      index: idx,
      name: productNames[idx],
      price: prices[idx],
      couponType: null,
    });
    openPopup("cart", 1300);
    setTimeout(() => setScreen("cart"), 600);
  }

  function renderCouponStack() {
    const layer = document.getElementById("coupon-stack-layer");
    if (!layer) return;
    layer.innerHTML = "";
    if (state.activeScreen !== "coupon") return;

    const order = ["cream", "dosirak", "dessert", "drink", "ramen"];
    const labels = {
      cream: "쿠폰_일반(크림빵)",
      dosirak: "쿠폰_도시락",
      dessert: "쿠폰_디저트",
      drink: "쿠폰_음료",
      ramen: "쿠폰_라면/간편식",
    };
    let row = 0;
    order.forEach((k) => {
      if (!state.coupon[k]) return;
      const card = document.createElement("div");
      card.className = "overlay-card";
      card.style.position = "absolute";
      card.style.left = "11px";
      card.style.width = "380px";
      card.style.top = `${439 + row * 172}px`;
      card.innerHTML = `<h4>${labels[k]}</h4><p>발급됨</p><div class="coupon-badge">~2026.04.30</div>`;
      layer.appendChild(card);
      row += 1;
    });
  }

  function renderCartStack() {
    const layer = document.getElementById("cart-stack-layer");
    if (!layer) return;
    layer.innerHTML = "";
    if (state.activeScreen !== "cart") return;

    state.cartItems.forEach((item, i) => {
      const card = document.createElement("div");
      card.className = "overlay-card";
      card.style.position = "absolute";
      card.style.left = "11px";
      card.style.width = "380px";
      card.style.top = `${120 + i * 170}px`;
      card.innerHTML = `
        <h4>${item.name}</h4>
        <p>${item.price.toLocaleString("ko-KR")}원</p>
        <button class="coupon-option on" data-cart-coupon="${i}">쿠폰사용버튼</button>
      `;
      layer.appendChild(card);
    });

    layer.querySelectorAll("[data-cart-coupon]").forEach((btn) => {
      btn.addEventListener("click", () => {
        state.activeCartCouponIndex = Number(
          btn.getAttribute("data-cart-coupon"),
        );
        openCouponSelect();
      });
    });
  }

  function openCouponSelect() {
    const layer = document.getElementById("coupon-select-layer");
    if (!layer) return;
    const available = [
      ["cream", "쿠폰선택_크림빵"],
      ["dosirak", "쿠폰선택_도시락"],
      ["dessert", "쿠폰선택_디저트"],
      ["drink", "쿠폰선택_음료"],
      ["ramen", "쿠폰선택_라면"],
    ];
    layer.innerHTML = `<div class="coupon-select">
      ${available
        .map(
          ([k, t]) =>
            `<button class="coupon-option ${state.coupon[k] ? "on" : "off"}" data-pick="${k}" ${state.coupon[k] ? "" : "disabled"}>${t}</button>`,
        )
        .join("")}
    </div>`;
    layer.classList.add("open");
    layer.querySelectorAll("[data-pick]").forEach((btn) => {
      btn.addEventListener("click", () => {
        const type = btn.getAttribute("data-pick");
        const idx = state.activeCartCouponIndex;
        if (idx == null) return;
        state.cartItems[idx].couponType = type;
        layer.classList.remove("open");
        renderCartStack();
      });
    });
    layer.addEventListener(
      "click",
      (e) => {
        if (e.target === layer) layer.classList.remove("open");
      },
      { once: true },
    );
  }

  function renderHotspots() {
    const screen = document.getElementById(`screen-${state.activeScreen}`);
    if (!screen) return;
    screen.querySelectorAll(".hs").forEach((n) => n.remove());

    const add = (cls, left, top, width, height, action) => {
      const b = document.createElement("button");
      b.className = `hs ${cls}`;
      b.style.left = `${left}px`;
      b.style.top = `${top}px`;
      b.style.width = `${width}px`;
      b.style.height = `${height}px`;
      b.addEventListener("click", action);
      screen.appendChild(b);
    };

    // global header coupon icon + back icon
    if (state.activeScreen !== "coupon")
      add("g-coupon", 340, 40, 26, 26, () => setScreen("coupon"));
    if (state.activeScreen !== "main")
      add("g-back", 12, 40, 26, 26, () => goBack());

    if (state.activeScreen === "main") {
      add("m-list", 80, 1246, 80, 92, () => setScreen("list"));
    }

    if (state.activeScreen === "list") {
      const startX = 16;
      const startY = 95;
      const cardW = 178;
      const cardH = 146;
      const gapY = 144;
      for (let i = 0; i < 16; i += 1) {
        const col = i % 2;
        const row = Math.floor(i / 2);
        const x = startX + col * 192;
        const y = startY + row * gapY;
        const detailIndex = i + 1;
        add(`list-item-${detailIndex}`, x, y, cardW, cardH, () => {
          state.currentDetailIndex = detailIndex;
          setScreen("detail");
        });
        add(`list-cart-${detailIndex}`, x + 150, y + 45, 22, 22, () => {
          state.currentDetailIndex = detailIndex;
          state.cartItems.push({
            index: detailIndex,
            name: productNames[detailIndex],
            price: prices[detailIndex],
            couponType: null,
          });
          openPopup("cart", 1300);
        });
      }
    }

    if (state.activeScreen === "event") {
      add("event-coupon", 70, 531, 262, 40, () => {
        state.coupon.cream = true;
        openPopup("cream", 2000);
      });
    }

    if (state.activeScreen === "detail") {
      add("detail-buy", 21, 1315, 360, 59, () => {
        const cat = categoryByIndex(state.currentDetailIndex);
        issueCategoryCoupon(cat);
        onDetailBuy();
      });
    }
  }

  function renderLayers() {
    const couponLayer = document.getElementById("coupon-stack-layer");
    const cartLayer = document.getElementById("cart-stack-layer");
    if (couponLayer) {
      couponLayer.style.position = "absolute";
      couponLayer.style.inset = "0";
      couponLayer.style.pointerEvents = "none";
      couponLayer.style.zIndex = "20";
    }
    if (cartLayer) {
      cartLayer.style.position = "absolute";
      cartLayer.style.inset = "0";
      cartLayer.style.pointerEvents = "none";
      cartLayer.style.zIndex = "20";
    }
    const cards = document.querySelectorAll(".overlay-card");
    cards.forEach((c) => (c.style.pointerEvents = "auto"));

    renderHotspots();
    renderCouponStack();
    renderCartStack();
  }

  function bind() {
    document.querySelectorAll("[data-go]").forEach((btn) => {
      btn.addEventListener("click", () =>
        setScreen(btn.getAttribute("data-go")),
      );
    });

    const popupLayer = document.getElementById("popup-layer");
    popupLayer?.addEventListener("click", () =>
      popupLayer.classList.remove("open"),
    );
  }

  bind();
  setScreen("main");
})();
