# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.draw_like_graph = -> 
    ctx = document.getElementById("myLikeChart").getContext('2d')
    data = {
      datasets: [{
          data: gon.dataset["like"]["data"],
          backgroundColor: [
                '#448aff',
                '#26c6da',
                '#4caf50',
                '#d4e157',
                '#ffca28',
                '#ff7043']
      }],
      labels: gon.dataset["like"]["labels"]
    }

    options = {
      legend: {
        display: false
      }
      title: {
        display: true,
        text: "いいね上位タグ"
      }
    }

    myChart = new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options
    })