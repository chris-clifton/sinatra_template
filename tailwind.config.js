module.exports = {
  content: [
    './views/**/*.{erb,haml,slim}',
    './public/**/*.{html,js}',
    './app/javascript/**/*.{js,ts}'
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: '#ef4444',
          dark: '#b91c1c'
        }
      }
    },
  },
  plugins: [],
}
