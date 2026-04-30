(() => {
  const state = {
    activeScreen: "main",
    modalOpen: false,
    activePopup: null,
    cart: [],
    couponFilter: "all",
    products: [],
    coupons: [],
    prototypeNodes: {},
  };

  const screenTitleMap = {
    main: "메인",
    list: "상품목록",
    event: "이벤트페이지",
    detail: "상품상세",
    coupon: "쿠폰함",
    cart: "장바구니",
  };

  const money = (v) => `${Number(v).toLocaleString("ko-KR")}원`;

  async function loadData() {
    const res = await fetch("./app.json");
    if (!res.ok) throw new Error("app.json 로드 실패");
    const data = await res.json();
    state.activeScreen = data.state?.activeScreen || "main";
    state.modalOpen = data.state?.modalOpen || false;
    state.activePopup = data.state?.activePopup || null;
    state.cart = data.state?.cart || [];
    state.couponFilter = data.state?.couponFilter || "all";
    state.products = data.products || [];
    state.coupons = data.coupons || [];
    state.prototypeNodes = data.prototypeNodes || {};
  }

  function setScreen(screen) {
    state.activeScreen = screen;
    document.querySelectorAll(".screen").forEach((el) => el.classList.remove("active"));
    const screenEl = document.getElementById(`screen-${screen}`);
    if (screenEl) screenEl.classList.add("active");
    const titleEl = document.getElementById("screen-title");
    if (titleEl) titleEl.textContent = screenTitleMap[screen] || "화면";
  }

  function openPopup(popupId) {
    const layer = document.getElementById("modal-layer");
    if (!layer) return;
    layer.classList.add("open");
    state.modalOpen = true;
    state.activePopup = popupId;
    layer.querySelectorAll(".popup").forEach((p) => p.classList.remove("open"));
    const target = document.getElementById(popupId);
    if (target) target.classList.add("open");
  }

  function closePopup() {
    const layer = document.getElementById("modal-layer");
    if (!layer) return;
    layer.classList.remove("open");
    layer.querySelectorAll(".popup").forEach((p) => p.classList.remove("open"));
    state.modalOpen = false;
    state.activePopup = null;
  }

  function addToCart(product) {
    if (!product) return;
    state.cart.push(product);
    renderCart();
  }

  function issueCoupon(couponId) {
    const stack = document.getElementById("coupon-stack");
    const coupon = state.coupons.find((c) => c.id === couponId);
    if (!stack || !coupon) return;
    const div = document.createElement("div");
    div.className = "product";
    div.innerHTML = `
      <strong>${coupon.title}</strong>
      <div>${coupon.discountRate}% 할인</div>
      <small>${coupon.expires} 까지</small>
    `;
    stack.prepend(div);
  }

  function renderProducts() {
    const list = document.getElementById("product-list");
    const events = document.getElementById("event-products");
    if (!list || !events) return;

    list.innerHTML = "";
    events.innerHTML = "";

    state.products.forEach((p) => {
      const card = document.createElement("article");
      card.className = "product";
      card.innerHTML = `
        <strong>${p.name}</strong>
        <div>${money(p.price)}</div>
        <small>${p.category}</small>
      `;
      list.appendChild(card);

      const eventCard = card.cloneNode(true);
      events.appendChild(eventCard);
    });
  }

  function renderCoupons() {
    const stack = document.getElementById("coupon-stack");
    if (!stack) return;
    stack.innerHTML = "";
    state.coupons.forEach((c) => {
      const card = document.createElement("article");
      card.className = "product";
      card.innerHTML = `
        <strong>${c.title}</strong>
        <div>${c.discountRate}% 할인</div>
        <small>${c.expires}</small>
      `;
      stack.appendChild(card);
    });
  }

  function renderCart() {
    const cartStack = document.getElementById("cart-stack");
    const sumOrder = document.getElementById("sum-order");
    const sumDiscount = document.getElementById("sum-discount");
    const sumTotal = document.getElementById("sum-total");
    if (!cartStack || !sumOrder || !sumDiscount || !sumTotal) return;

    cartStack.innerHTML = "";
    let order = 0;
    let discount = 0;

    state.cart.forEach((item) => {
      order += item.price;
      const discountAmount = Math.round(item.price * 0.1);
      discount += discountAmount;

      const card = document.createElement("article");
      card.className = "product";
      card.innerHTML = `
        <strong>${item.name}</strong>
        <div>정가 ${money(item.price)}</div>
        <small>할인 ${money(discountAmount)}</small>
      `;
      cartStack.appendChild(card);
    });

    sumOrder.textContent = money(order);
    sumDiscount.textContent = money(discount);
    sumTotal.textContent = money(Math.max(order - discount, 0));
  }

  function bindEvents() {
    document.querySelectorAll("[data-go]").forEach((btn) => {
      btn.addEventListener("click", () => setScreen(btn.getAttribute("data-go")));
    });

    document.querySelector("[data-action='open-coupon']")?.addEventListener("click", () => setScreen("coupon"));
    document.querySelector("[data-action='open-cart']")?.addEventListener("click", () => setScreen("cart"));
    document.querySelector("[data-action='back']")?.addEventListener("click", () => setScreen("main"));

    document.querySelector("[data-action='add-to-cart']")?.addEventListener("click", () => {
      addToCart(state.products[0]);
      openPopup("popup-cart-done");
    });

    document.querySelector("[data-action='open-coupon-popup-cream']")?.addEventListener("click", () => {
      issueCoupon("c3");
      openPopup("popup-coupon-cream");
    });

    document.getElementById("modal-layer")?.addEventListener("click", (e) => {
      if (e.target && e.target.id === "modal-layer") closePopup();
    });
  }

  async function bootstrap() {
    try {
      await loadData();
      renderProducts();
      renderCoupons();
      renderCart();
      bindEvents();
      setScreen(state.activeScreen);
    } catch (e) {
      console.error(e);
    }
  }

  bootstrap();
})();
