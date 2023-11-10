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
    themes: [
      {
        mytheme: {
          "primary": "#7dd3fc",
          "secondary": "#a7f3d0",
          "accent": "#fde68a",
          "neutral": "#cffafe",
          "base-100": "#f3f4f6",
          "info": "#bae6fd",
          "success": "#6ee7b7",
          "warning": "#fb923c",
          "error": "#f87171",
        },
      },
    ],
  },
}
