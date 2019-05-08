$(document).on('turbolinks:load', function() {
  // count time to do test
  var interval1, count, min, sec;
  count = 60;
  min = Math.floor(count/60)
  sec = Math.floor(count%60)

  $('.clock').text(min.toString()+':'+sec.toString());
  countdown();

  function countdown() {
    clearInterval(interval1);

    interval1 = setInterval( function() {
      var timer = $('.clock').html();
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
        $('#exampleModalCenter').modal({backdrop: 'static', keyboard: false});
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
  // count time to play audio

  var Pause, interval, settime, timer, total_time;
  timer = 5;
  interval = setInterval((function() {
    timer--;
    $('.timer').text(timer);
    if (timer === 0) {
      Pause();
      document.getElementById('timer-beep').play();
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
  Pause = function() {
    $('.timer-beep').each(function(i) {
      $(this).get($('fieldset').index(i)).pause();
      $(this).get($('fieldset').index(i)).currentTime = 0;
    });
  };
  // Analyze click next, previous, finish button
  $('.next-button').click(function() {
    var current, next;
    current = $(this).parent();
    next = $(this).parent().next();
    Pause();
    current.hide();
    next.show();
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
        Pause();
        $('.timer-beep').get($('fieldset').index(next)).play();
        clearInterval(interval);
      }
    }), 1000);
  });

  var senCouter;
  // Text to Speech
  function text_to_speech(){
    var words = new SpeechSynthesisUtterance( $("#content" + (senCounter - 1)).text() );
    speechSynthesis.speak(words);
  }
  $('.audio').click(function() {
    text_to_speech();
  });
});
