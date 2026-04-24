import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/reference-ui/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        ref: {
          lime: "rgb(var(--color-brand-lime) / <alpha-value>)",
          "lime-strong": "rgb(var(--color-brand-lime-strong) / <alpha-value>)",
          purple: "rgb(var(--color-brand-purple) / <alpha-value>)",
          violet: "rgb(var(--color-brand-violet) / <alpha-value>)",
          bg: "rgb(var(--color-bg) / <alpha-value>)",
          surface: "rgb(var(--color-surface) / <alpha-value>)",
          "surface-soft": "rgb(var(--color-surface-soft) / <alpha-value>)",
          border: "rgb(var(--color-border) / <alpha-value>)",
          text: {
            primary: "rgb(var(--color-text-primary) / <alpha-value>)",
            secondary: "rgb(var(--color-text-secondary) / <alpha-value>)",
          },
        },
      },
      borderRadius: {
        ref: "18px",
      },
      boxShadow: {
        "ref-card": "0 6px 24px rgba(0, 0, 0, 0.08)",
      },
    },
  },
  plugins: [],
};

export default config;
