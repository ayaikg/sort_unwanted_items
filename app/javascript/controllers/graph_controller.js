import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"
Chart.register(...registerables)

// Connects to data-controller="graph"
export default class extends Controller {
  static targets = ["bar"]

  connect() {
    const element = this.barTarget
    this.mybar = new Chart(element.getContext('2d'), {
      type: 'bar',
      data: {
        labels: ['アイテム1'],
        datasets: [
          {
            label: '衣類',
            data: [60],
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1,
            barPercentage: 0.4
          },
          {
            label: '書籍',
            data: [50],
            backgroundColor: 'rgba(54,162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1,
            borderRadius: 10,
            barPercentage: 0.4
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        indexAxis: 'y',
        scales: {
          x: {
            stacked: true,
            grid: {
              display: false
            },
            ticks: {
              display: false
            },
            border: {
              display: false
            },
          },
          y: {
            stacked: true,
            grid: {
              display: false
            },
            ticks: {
              display: false
            },
            border: {
              display: false
            },
          },
        },
      },
    })
  }
}
