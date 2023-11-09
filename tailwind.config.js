module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    container: {
      center: true
    },
  },
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: ["cupcake"]
  }
}
