$(document).on('turbolinks:load', function() {
  var senCounter = 1;
  var interval;
  var timer;

  senCounter == 1 ? prepaireRead() : null;

  $('#data-1').show();
  
  $('#audio').click(function() {
    if(timer == 0) {
      text_to_speech();
    }
  });

  $('#verify-result').click(function() {
    clearInterval(interval);
    var textInput = $("#sens-content"+ senCounter).val();
    if(textInput == ""){
      Swal.fire({
        type: 'warning',
        title: 'Warning',
        text: 'You should type what you hear in the box below.',
      })
    }
    else{
      $("#verify-result").addClass("d-none");
      sentence_result();
    }
  });

  $('#retry-button').click(function() {
    $("#next-button").addClass("d-none");
    $("#retry-button").addClass("d-none");
    $("#result-" + senCounter).addClass("d-none");
    $("#verify-result").removeClass("d-none");
    prepaireRead();
  });

  $('#next-button').click(function() {
    $("#next-button").addClass("d-none");
    $("#retry-button").addClass("d-none");
    $("#result").addClass("d-none");
    $("#verify-result").removeClass("d-none");
    
    speechSynthesis.cancel();
    $('#data-' + senCounter).hide();
    senCounter ++;

    $('#data-' + senCounter).show();
    prepaireRead();
  });

  function prepaireRead(){
    $("#verify-result").attr("disabled", true);
    timer = 5;
    interval = setInterval((function() {
      timer--;
      $('.timer').text(timer);
      if (timer === 0) {
        text_to_speech();
        clearInterval(interval);

        $("#verify-result").attr("disabled", false);
      }
    }), 1000);
  }

  function text_to_speech(){
    var words = $("#content" + senCounter).text();
    if(!responsiveVoice.isPlaying()){
      responsiveVoice.speak(words, "UK English Male", { rate: 1 });
    }
  }

  function sentence_result(){
    let originalHTML = document.getElementById('sens-content' + senCounter).value;
    let newHTML = $("p#content" + senCounter).text();
    // Diff HTML strings
    let output = htmldiff(originalHTML, newHTML);
    // Count % matching
    let similarity = compareTwoStrings(originalHTML, newHTML);

    document.getElementById("output-" + senCounter).innerHTML = output;
    $("#accuracy-" + senCounter).attr('value', similarity);
    $("#result-" + senCounter).removeClass("d-none");
    $("#next-button").removeClass("d-none");
    $("#retry-button").removeClass("d-none");

    // Show HTML diff output as HTML
    var rs = Math.round(similarity * 100);
    document.querySelector('#percent-' + (senCounter)).textContent = rs + '%';
    var ctx = document.getElementById('accuracy-' + senCounter).getContext('2d');
    var accuracyChart = new Chart(ctx, {
      type: 'pie',
      data: {
        datasets: [{
          data: [rs, 100-rs],
          backgroundColor: ['#57b0f3']
        }],
      },
      options: {
        cutoutPercentage: 50
      }
    });
    
    //
    var suggest = "unavailable result";
    console.log(rs);
    console.log(typeof rs);

    if (rs <= 50){
      suggest = "Bad";
    }      
    else if(rs <= 85) {
      suggest = "Good";
    }
    else if(rs <= 100) {
      suggest = "Great";
    }

    $("#suggest")[0].innerHTML = suggest;
  }
});