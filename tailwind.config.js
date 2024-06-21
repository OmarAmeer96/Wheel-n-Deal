/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,ts,scss}"],
  safelist: ["bg-orange-400"],
  theme: {
    extend: {
      colors: {
        primary: "#ff981a",
        gray: {
          1: "#e2e2e2",
          2: "#d1d1d6",
          3: "#d0d5dd",
          4: "#b9bbbd",
          5: "#9e9e9e",
          6: "#808080",
          7: "#333333",
          8: "#667085",
        },
        black: {
          primary: "#2c2c2c",
          light: "#2c2c2c33",
          dark: "#202224",
        },
        green: {
          completed: "#00b69b",
        },
        red: {
          rejected: "#ef3826",
        },
      },
      backgroundImage: {
        gradient: "linear-gradient(248deg, #fad691 0%, #f9f5d7 100%)",
      },
      borderColor: {
        green: {
          completed: "#00b69b",
        },
        red: {
          rejected: "#ef3826",
        },
      },
    },
  },
  plugins: [],
};
