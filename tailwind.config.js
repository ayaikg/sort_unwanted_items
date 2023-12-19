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
          "primary": "#97cadb",
          "secondary": "#018abe",
          "accent": "#001b48",
          "neutral": "#d6e8ee",
          "base-100": "#ffffff",
          "info": "#02457a",
          "success": "#f27f0c",
          "warning": "#f7ad19",
          "error": "#f87272",
        },
      },
    ],
  },
}
