$(document).on('turbolinks:load', function() {
    var timeRecord;
    var word = "";
    var idWord = "";
    var result = document.getElementById('erea_Say');
    function showInfoWork(e) {
        word = document.getElementById(e.id).innerHTML;
        responsiveVoice.speak(word, "UK English Female", { rate: 0.9 });
        document.getElementById("word").innerHTML = word;

        $("#" + idWord).removeClass("text-info");
        $("#" + e.id).addClass("text-info");

        try {
            document.getElementById("word-example").removeChild(document.getElementById("word-example").lastElementChild)
        } catch (error) {
            
        }

        if(e.id == "work_say")
        {
            var para = document.createElement("p");
            var node = document.createTextNode('"She say love me but I know she do not."');
            para.appendChild(node);
            var element = document.getElementById("word-example");
            element.appendChild(para);
        }
        else{
            var para = document.createElement("p");
            var node = document.createTextNode('"Eight days a week."');
            para.appendChild(node);
            var element = document.getElementById("word-example");
            element.appendChild(para);
        }

        $("#infor_Result").removeClass("d-none");
        $("#erea_word").removeClass("d-none");

        document.getElementById("erea_Say").innerHTML = "";
        $("#result").addClass("d-none");

        idWord = e.id;
    }
    
    function speakWord(){
        timeRecord = 5;
        if(word !== ""){
            document.getElementById("erea_Say").innerHTML = "";
            $("#result").addClass("d-none");
            record();
        }
        else{
            alert("The word don't choice!!!");
        }
    }

    function record(){
        startConverting();
        start = setInterval(function () {
            timeRecord --;
            var rs = document.getElementById("erea_Say").innerHTML;
            if(timeRecord == 0 || rs != ""){
                $("#result").removeClass("d-none");
                showResult();

                stopConverting();
                clearInterval(start);

                if(rs === ""){
                    document.getElementById("erea_Say").innerHTML = "None";
                }
            }
        }, 1000);
    }

    function showResult(){
        var ctx = document.getElementById('result').getContext('2d');
        var accuracyChart = new Chart(ctx, {
        type: 'pie',
        data: {
            datasets: [{
            data: [50],
            backgroundColor: ['#57b0f3']
            }],
        },
        options: {
            cutoutPercentage: 50
        }
        });
    }

    function reviewSpeak(id){
        responsiveVoice.speak(document.getElementById("word").innerHTML, "UK English Female", { rate: 0.9 });
    }

    // Speech to text

  function startConverting () {
    if('webkitSpeechRecognition' in window) {
      speechRecognizer = new webkitSpeechRecognition();
      speechRecognizer.continuous = true;
      speechRecognizer.interimResults = true;
      speechRecognizer.lang = 'en-US';
      speechRecognizer.start();
    }else if ('SpeechRecognition' in window) {
      speechRecognizer = new SpeechRecognition();
      speechRecognizer.addEventListener('start', function() { 
        console.log('Speech recognition service has started');
      });
      speechRecognizer.onstart = function() {
        console.log('Speech recognition service has started');
      }
    }
    
    
    // speechRecognizer.start();

    var finalTranscripts = '';

    speechRecognizer.onresult = function(event) {
      var interimTranscripts = '';
      for(var i = event.resultIndex; i < event.results.length; i++){
        var transcript = event.results[i][0].transcript;
        transcript.replace("\n", "<br>");
        if(event.results[i].isFinal) {
          finalTranscripts += transcript;
        }else{
          interimTranscripts += transcript;
        }
      }
      result.innerHTML = finalTranscripts;
    };
    speechRecognizer.onerror = function (event) {

    };
    //}// else {
    //   confirm("Please set: \n media.webspeech.recognition.enable in about:config \n to get all feature of web");
    // }
  };
  function stopConverting () {
    if('webkitSpeechRecognition' in window) {
      speechRecognizer.continuous = false;
    }
      speechRecognizer.stop();
     

  };
  // ------------Speech to text
});