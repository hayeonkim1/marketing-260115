const buttons = document.querySelectorAll(".buy-btn");

buttons.forEach((btn) => {
    btn.addEventListener("click", () => {
        alert("상품을 구매하셨습니다!")
    });
});