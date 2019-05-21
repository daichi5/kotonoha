# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.draw_post_graph = -> 
    ctx = document.getElementById("myPostChart").getContext('2d')
    data = {
      datasets: [{
          data: gon.dataset["post"]["data"],
          backgroundColor: ['rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)']
      }],
      labels: gon.dataset["post"]["labels"]
    }

    options = {
      legend: {
        display: false
      }
      title: {
        display: true,
        text: "投稿上位タグ"
      }
    }

    myChart = new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options
    })