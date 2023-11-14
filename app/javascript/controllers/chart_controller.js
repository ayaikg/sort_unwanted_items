import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"
Chart.register(...registerables)

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["canvas"]

  connect() {
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
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true
          },
        },
      },
    })
  }
}
