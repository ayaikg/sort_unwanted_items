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
    extend: {
      keyframes: {
        flashFade: {
          "0%": { tramsform: "translateX(180px)", opacity: 0 },
          "20%": { transform: "translateX(0)", opacity: 1 },
          "80%": { transform: "translateX(0)", opacity: 1 },
          "100%": { transform: "translateX(180px)", opacity: 0 },
        },
      },
      animation: {
        flash: "flashFade 7.0s forwards",
      },
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
          "success": "#dcfce7",
          "warning": "#f7ad19",
          "error": "#fecaca",
        },
      },
    ],
  },
}
