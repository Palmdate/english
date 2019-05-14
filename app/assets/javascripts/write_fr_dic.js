$(document).on('turbolinks:load', function() {
  // count time to do test
  var interval1, count, min, sec;
  count = 60;
  min = Math.floor(count/60)
  sec = Math.floor(count%60)

  $('.clock').text(min.toString()+':'+sec.toString());
  countdown();

  // Function count 60s
  function countdown() {
    clearInterval(interval1);

    interval1 = setInterval( function() {
      var timer = $('.clock').text();
      timer = timer.split(':');
      var minutes = timer[0];
      var seconds = timer[1];
      seconds -= 1;
      if (minutes < 0) return;
      else if (seconds < 0 && minutes != 0) {
        minutes -= 1;
        seconds = 59;
      }
      else if (seconds < 10 && length.seconds != 2) seconds = '0' + seconds;

      $('.clock').html(minutes + ':' + seconds);

      if (minutes == 0 && seconds == 0)
      {
        clearInterval(interval1);
      };
    }, 1000);

  };
  // --------------------
  // open result when time out
  $('.finish').click(function() {
    clearInterval(interval1);
  });
  // ------------------------

  // Main funct: count time to play audio
  var Pause, interval, settime, timer, total_time;

  timer = 5;
  interval = setInterval((function() {
    timer--;
    $('.timer').text(timer);
    if (timer === 0) {
      text_to_speech();
      clearInterval(interval);
    }
  }), 1000);
 
  
  $('.next-button').prop('disabled', true);
  $('.prev-button').prop('disabled', true);
  setTimeout((function() {
    $('.next-button').prop('disabled', false);
    $('.prev-button').prop('disabled', false);
  }), 10000);
  // -----------------------------
  
  // Analyze click next, previous, finish button
  $('.next-button').click(function() {
    // Audio
    senCounter ++;
    $('.result-hatest').hide();
    $('.audio').removeClass('fa fa-pause-play-o');
    $('.audio').addClass('fa fa-play-circle-o');
    // Action for show next sentences
    var current, next;
    current = $(this).parent();
    next = $(this).parent().next();

    current.hide();
    next.show();
    // Count time 60s
    $('.clock').text(min.toString()+':'+sec.toString());
    countdown();
    speechSynthesis.cancel();
    
    $('.next-button').prop('disabled', true);
    $('.prev-button').prop('disabled', true);
    $('.finish').prop('disabled', true);
    setTimeout((function() {
      $('.next-button').prop('disabled', false);
      $('.prev-button').prop('disabled', false);
      $('.finish').prop('disabled', false);
    }), 10000);
    timer = 5;
    interval = setInterval((function() {
      timer--;
      $('.timer').text(timer);
      if (timer === 0) {
        text_to_speech();
        clearInterval(interval);
      }
    }), 1000);
    
  });
  
  var senCounter = 1;
  // Text to Speech
  function text_to_speech(){
    $('.audio').removeClass('fa fa-play-circle-o');
    $('.audio').addClass('fa fa-pause-circle-o');
    var words = $("#content" + senCounter).text();
    responsiveVoice.speak(words, "UK English Male", { rate: 1 });
  }

  function sentence_result(){
    let originalHTML = document.getElementById('sens-content' + senCounter).value;
    let newHTML = $("p#content" + senCounter).text();
    // Diff HTML strings
    let output = htmldiff(originalHTML, newHTML);
    // Count % matching
    let similarity = compareTwoStrings(originalHTML, newHTML);

    // Show HTML diff output as HTML
    document.getElementById("output").innerHTML = output;
    $("#accuracy").attr('value', similarity);
    document.getElementById("text_accuracy").innerHTML = (Math.round(similarity * 100)).toString() + "%";
  }
  
  $('.infor').click(function() {
    $('.result-hatest').toggle();
    sentence_result();
  });
  
});
