const THEME_KEY = "figma-poster-theme";
const toggleButton = document.getElementById("theme-toggle");

function applyTheme(theme) {
  const isDark = theme === "dark";
  document.body.classList.toggle("dark-mode", isDark);
  toggleButton.textContent = isDark ? "Light Mode" : "Dark Mode";
  toggleButton.setAttribute("aria-label", isDark ? "라이트 모드 전환" : "다크 모드 전환");
}

function getInitialTheme() {
  const savedTheme = localStorage.getItem(THEME_KEY);
  if (savedTheme === "light" || savedTheme === "dark") {
    return savedTheme;
  }

  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  return prefersDark ? "dark" : "light";
}

let currentTheme = getInitialTheme();
applyTheme(currentTheme);

toggleButton.addEventListener("click", () => {
  currentTheme = currentTheme === "dark" ? "light" : "dark";
  localStorage.setItem(THEME_KEY, currentTheme);
  applyTheme(currentTheme);
});
