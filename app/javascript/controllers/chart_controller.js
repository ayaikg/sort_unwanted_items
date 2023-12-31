import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"
Chart.register(...registerables)

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["canvas"]

  connect () {
    this.renderChart()
    document.addEventListener("turbo:load", this.renderChart.bind(this))
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.renderChart.bind(this))
    this.destroyChart()
  }

  renderChart() {
    if (this.mychart) {
      this.destroyChart()
    }
    const element = this.canvasTarget
    const disposalDates = gon.disposal_dates
    const disposalCounts = gon.disposal_counts
    this.mychart = new Chart(element.getContext('2d'), {
      type: 'bar',
      data: {
        labels: disposalDates,
        datasets: [
          {
            label: '断捨離数',
            data: disposalCounts,
            backgroundColor: 'rgba(30, 140, 180, 0.3)',
            borderColor: 'rgba(30, 140, 180, 1)',
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 1,
            }
          },
        },
      },
    })
  }
  
  destroyChart() {
    if (this.mychart) {
      this.mychart.destroy()
      this.mychart = null
    }
  }
}