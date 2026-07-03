const viewItemBtn = document.getElementById("viewItemBtn");
const addToCartBtn = document.getElementById("addToCartBtn");
const purchaseBtn = document.getElementById("purchaseBtn");

const viewItem = () => {
  console.log("viewItem");
};

const addToCart = () => {
  console.log("addToCart");
};

const purchase = () => {
  console.log("purchase");
};

viewItemBtn.addEventListener("click", viewItem);

addToCartBtn.addEventListener("click", addToCart);
