// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require survey_page/survey_page_expanding_cols
import "@hotwired/turbo-rails";
// import "controllers";
import "@hotwired/turbo-rails"

import "Chartkick"
import "Chart.bundle"

const ctx = document.getElementById('githubChart').getContext('2d');
const chart = new Chart(ctx, {
  type: 'line',
  data: {
    // Provide data for the chart
  },
});