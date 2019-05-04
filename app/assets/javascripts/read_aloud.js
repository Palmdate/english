$(document).on('turbolinks:load', function() {
  var readCounter = 1;
  // $('p#content0').show();
  $('#next-read0').show();
  var newHTML = $('p#content0').text();
  var result = document.getElementById('result0');
  
  // Play, download recoring
  function WzRecorder(config) {
    config = config || {};

    var self = this;
    var audioInput;
    var audioNode;
    var bufferSize = config.bufferSize || 4096;
    var recordedData = [];
    var recording = false;
    var recordingLength = 0;
    var startDate;
    var audioCtx;

    this.toggleRecording = function() {
      recording ? self.stop() : self.start();
    };

    this.start = function() {
      // reset any previous data
      recordedData = [];
      recordingLength = 0;

      // webkit audio context shim
      audioCtx = new (window.AudioContext || window.webkitAudioContext)();

      if (audioCtx.createJavaScriptNode) {
        audioNode = audioCtx.createJavaScriptNode(bufferSize, 1, 1);
      } else if (audioCtx.createScriptProcessor) {
        audioNode = audioCtx.createScriptProcessor(bufferSize, 1, 1);
      } else {
        throw "WebAudio not supported!";
      }

      audioNode.connect(audioCtx.destination);

      navigator.mediaDevices
        .getUserMedia({ audio: true })
        .then(onMicrophoneCaptured)
        .catch(onMicrophoneError);
      startConverting();
    };

    this.stop = function() {
      stopRecording(function(blob) {
        self.blob = blob;
        config.onRecordingStop && config.onRecordingStop(blob);
      });
      // stopConverting();
    };

    this.upload = function(url, params, callback) {
      var formData = new FormData();
      formData.append("audio", self.blob, config.filename || "recording.wav");

      for (var i in params) formData.append(i, params[i]);

      var request = new XMLHttpRequest();
      request.upload.addEventListener("progress", function(e) {
        callback("progress", e, request);
      });
      request.upload.addEventListener("load", function(e) {
        callback("load", e, request);
      });

      request.onreadystatechange = function(e) {
        var status = "loading";
        if (request.readyState == 4) {
          status = request.status == 200 ? "done" : "error";
        }
        callback(status, e, request);
      };

      request.open("POST", url);
      request.send(formData);
    };

    function stopRecording(callback) {
      // stop recording
      recording = false;

      // to make sure onaudioprocess stops firing
      window.localStream.getTracks().forEach(track => {
        track.stop();
      });
      audioInput.disconnect();
      audioNode.disconnect();

      exportWav(
        {
          sampleRate: sampleRate,
          recordingLength: recordingLength,
          data: recordedData
        },
        function(buffer, view) {
          self.blob = new Blob([view], { type: "audio/wav" });
          callback && callback(self.blob);
        }
      );
    }

    function onMicrophoneCaptured(microphone) {
      if (config.visualizer) visualize(microphone);

      // save the stream so we can disconnect it when we're done
      window.localStream = microphone;

      audioInput = audioCtx.createMediaStreamSource(microphone);
      audioInput.connect(audioNode);

      audioNode.onaudioprocess = onAudioProcess;

      recording = true;
      self.startDate = new Date();

      config.onRecordingStart && config.onRecordingStart();
      sampleRate = audioCtx.sampleRate;
    }

    function onMicrophoneError(e) {
      console.log(e);
      alert("Unable to access the microphone.");
    }

    function onAudioProcess(e) {
      if (!recording) {
        return;
      }

      recordedData.push(new Float32Array(e.inputBuffer.getChannelData(0)));
      recordingLength += bufferSize;

      self.recordingLength = recordingLength;
      self.duration = new Date().getTime() - self.startDate.getTime();

      config.onRecording && config.onRecording(self.duration);
    }

    function visualize(stream) {
      var canvas = config.visualizer.element;
      if (!canvas) return;

      var canvasCtx = canvas.getContext("2d");
      var source = audioCtx.createMediaStreamSource(stream);

      var analyser = audioCtx.createAnalyser();
      analyser.fftSize = 2048;
      var bufferLength = analyser.frequencyBinCount;
      var dataArray = new Uint8Array(bufferLength);

      source.connect(analyser);

      function draw() {
        // get the canvas dimensions
        var width = canvas.width,
            height = canvas.height;

        // ask the browser to schedule a redraw before the next repaint
        requestAnimationFrame(draw);

        // clear the canvas
        canvasCtx.fillStyle = config.visualizer.backcolor || "#fff";
        canvasCtx.fillRect(0, 0, width, height);

        if (!recording) return;

        canvasCtx.lineWidth = config.visualizer.linewidth || 2;
        canvasCtx.strokeStyle = config.visualizer.forecolor || "#333";

        canvasCtx.beginPath();

        var sliceWidth = width * 1.0 / bufferLength;
        var x = 0;

        analyser.getByteTimeDomainData(dataArray);

        for (var i = 0; i < bufferLength; i++) {
          var v = dataArray[i] / 128.0;
          var y = v * height / 2;

          i == 0 ? canvasCtx.moveTo(x, y) : canvasCtx.lineTo(x, y);
          x += sliceWidth;
        }

        canvasCtx.lineTo(canvas.width, canvas.height / 2);
        canvasCtx.stroke();
      }

      draw();
    }

    function exportWav(config, callback) {
      function inlineWebWorker(config, cb) {
        var data = config.data.slice(0);
        var sampleRate = config.sampleRate;
        data = joinBuffers(data, config.recordingLength);

        function joinBuffers(channelBuffer, count) {
          var result = new Float64Array(count);
          var offset = 0;
          var lng = channelBuffer.length;

          for (var i = 0; i < lng; i++) {
            var buffer = channelBuffer[i];
            result.set(buffer, offset);
            offset += buffer.length;
          }

          return result;
        }

        function writeUTFBytes(view, offset, string) {
          var lng = string.length;
          for (var i = 0; i < lng; i++) {
            view.setUint8(offset + i, string.charCodeAt(i));
          }
        }

        var dataLength = data.length;

        // create wav file
        var buffer = new ArrayBuffer(44 + dataLength * 2);
        var view = new DataView(buffer);

        writeUTFBytes(view, 0, "RIFF"); // RIFF chunk descriptor/identifier
        view.setUint32(4, 44 + dataLength * 2, true); // RIFF chunk length
        writeUTFBytes(view, 8, "WAVE"); // RIFF type
        writeUTFBytes(view, 12, "fmt "); // format chunk identifier, FMT sub-chunk
        view.setUint32(16, 16, true); // format chunk length
        view.setUint16(20, 1, true); // sample format (raw)
        view.setUint16(22, 1, true); // mono (1 channel)
        view.setUint32(24, sampleRate, true); // sample rate
        view.setUint32(28, sampleRate * 2, true); // byte rate (sample rate * block align)
        view.setUint16(32, 2, true); // block align (channel count * bytes per sample)
        view.setUint16(34, 16, true); // bits per sample
        writeUTFBytes(view, 36, "data"); // data sub-chunk identifier
        view.setUint32(40, dataLength * 2, true); // data chunk length

        // write the PCM samples
        var index = 44;
        for (var i = 0; i < dataLength; i++) {
          view.setInt16(index, data[i] * 0x7fff, true);
          index += 2;
        }

        if (cb) {
          return cb({
            buffer: buffer,
            view: view
          });
        }

        postMessage({
          buffer: buffer,
          view: view
        });
      }

      var webWorker = processInWebWorker(inlineWebWorker);

      webWorker.onmessage = function(event) {
        callback(event.data.buffer, event.data.view);

        // release memory
        URL.revokeObjectURL(webWorker.workerURL);
      };

      webWorker.postMessage(config);
    }

    function processInWebWorker(_function) {
      var workerURL = URL.createObjectURL(
        new Blob(
          [
            _function.toString(),
            ";this.onmessage = function (e) {" + _function.name + "(e.data);}"
          ],
          {
            type: "application/javascript"
          }
        )
      );

      var worker = new Worker(workerURL);
      worker.workerURL = workerURL;
      return worker;
    }
  }

  var recorder = new WzRecorder({
    onRecordingStop: function(blob) {
      document.getElementById("player" + (readCounter - 1)).src = URL.createObjectURL(blob);  
    },
    onRecording: function(milliseconds) {
      document.getElementById("duration" + (readCounter - 1)).innerText = milliseconds + "ms";
    },
    visualizer: {
      element: document.getElementById('myCanvas' + (readCounter - 1))
    }
  });
  // Play, download recoring

  // Speech to text
  
  function startConverting () {

    if('webkitSpeechRecognition' in window) {
      var speechRecognizer = new webkitSpeechRecognition();
      speechRecognizer.stop();
      speechRecognizer.continuous = true;
      speechRecognizer.interimResults = true;
      speechRecognizer.lang = 'en-US';
      speechRecognizer.start();

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
        result.innerHTML = finalTranscripts + '<span style="color: #999">' + interimTranscripts + '</span>';
      };
      speechRecognizer.onerror = function (event) {

      };
    }else {
      result.innerHTML = 'Your browser is not supported. Please download Google chrome or Update your Google chrome!!';
    }
  };
  // function stopConverting () {
  //    if('webkitSpeechRecognition' in window) {
      
  //      speechRecognizer.stop();
  //      speechRecognizer.continuous = false;
  //    }
  // };
  // ------------Speech to text


  // main function
  $('#btnStart').click(function() {
    
    start_Record();
    startConverting();

  });
  $('#btnStop').click(function() {
    stop_Record();

    let originalHTML = $('#result'+ (readCounter - 1)).text();
    newHTML = $("p#content" + (readCounter - 1)).text();
    // Diff HTML strings
    let output = htmldiff(originalHTML, newHTML);

    // Show HTML diff output as HTML
    
    document.getElementById("output" + (readCounter - 1)).innerHTML = output; 
  });
  $('#btnAgain').click(function() {
    reload_Record();
  });
  $('#btnNext').click(function() {
    // next_Record();
    
    
    $('#next-read' + (readCounter - 1)).hide();
    $('#next-read' + readCounter).show();
    // $("p#content" + (readCounter - 1)).hide();
    // $("p#content" + readCounter).show();
    // $('#paragrap' + (readCounter - 1)).hide();
    // $('#paragrap' + readCounter).show();
    readCounter ++;
    result = document.getElementById('result' + readCounter);
    reload_Record();
    
    
  });
  // Text to speech
  var utterance = new window.SpeechSynthesisUtterance();
  utterance.volume = 1;
  utterance.rate = 1;
  utterance.pitch = 1;
  utterance.lang = 'en-US';
  var words = new SpeechSynthesisUtterance( $("#textbox").val() );


  // document.getElementById("btn")

  $('span.la').on('click', function(){
    if ($('span.la').hasClass('fa-play-circle-o'))
    {
      $('span.la').removeClass('fa-play-circle-o');
      $('span.la').addClass('fa-pause-circle-o');
      var words = new SpeechSynthesisUtterance( $("#content" + (readCounter - 1)).text() );
      speechSynthesis.speak(words);
    }
    else
    {
      $('span.la').removeClass('fa-pause-circle-o');
      $('span.la').addClass('fa-play-circle-o');
      speechSynthesis.cancel();
    }
  });
  // let originalHTML = `
  //   <div>
  //   <h1>Article Title</h1>
  //   <p>This is a rudimentary demo of showing a blog post's most recent edit history as it renders.</p>
  //   <p><a href="http://example.com">This is a link test.</a></p>
  //   </div>
  //   `;

  //   let newHTML = `
  // <div>
  // <h1>Article Title &ndash; Revision 2</h1>
  // <p>This is a simple demo showing a blog post's most recent editing history.</p>
  // <p><a href="http://example.com">This is a sample link.</a></p>
  // </div>
  // `;
  function result () {
    let originalHTML = $('#result').text();
    
    // Diff HTML strings
    let output = htmldiff(originalHTML, newHTML);

    // Show HTML diff output as HTML
   
    document.getElementById("output").innerHTML = output; 
    
  };
  

  // text to speech
  // cong
  function toHHMMSS(seconds) {
    var sec_num = parseInt(seconds, 10); // don't forget the second param
    var hours   = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = sec_num - (hours * 3600) - (minutes * 60);

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (seconds < 10) {seconds = "0"+seconds;}
    //return hours + ':' + minutes + ':' + seconds;
    return minutes + ':' + seconds;
  };

  // var wavesurferorigin;
  // var wavesurfer;

  // wavesurferorigin = WaveSurfer.create({
  //   container: '#waveformorigin',
  //   waveColor: 'gray',
  //   progressColor: '#003359',
  //   height: 50
  // });


  // $(".your-record-audio-origin-play").on('click', function(){
  //   $(".your-record-audio-origin-play").addClass("d-none");
  //   $(".your-record-audio-origin-pause").removeClass("d-none");
  //   var durationTimeOrigin = wavesurferorigin.getDuration();

  //   setInterval(function () {
  //     var currentTimeOrigin = wavesurferorigin.getCurrentTime();

  //     document.querySelector('#timeOrigin').textContent = toHHMMSS(currentTimeOrigin) + "/" + toHHMMSS(durationTimeOrigin);

  //     if (currentTimeOrigin == durationTimeOrigin){
  //       $(".your-record-audio-origin-pause").addClass("d-none");
  //       $(".your-record-audio-origin-play").removeClass("d-none");
  //     }
  //   }, durationTimeOrigin);


  //   wavesurferorigin.playPause();
  // });

  // $(".your-record-audio-origin-pause").on('click', function(){
  //   $(".your-record-audio-origin-pause").addClass("d-none");
  //   $(".your-record-audio-origin-play").removeClass("d-none");

  //   var durationTimeOrigin = wavesurferorigin.getDuration();

  //   setInterval(function () {
  //     var currentTimeOrigin = wavesurferorigin.getCurrentTime();

  //     document.querySelector('#timeOrigin').textContent = toHHMMSS(currentTimeOrigin) + "/" + toHHMMSS(durationTimeOrigin);
  //   }, durationTimeOrigin);

  //   wavesurferorigin.playPause();
  // });

  // wavesurfer = WaveSurfer.create({
  //   container: '#waveform',
  //   waveColor: 'gray',
  //   progressColor: '#003359',
  //   height: 50
  // });


  // $(".your-record-audio-play").on('click', function(){
  //   $(".your-record-audio-play").addClass("d-none");
  //   $(".your-record-audio-pause").removeClass("d-none");

  //   var durationTime = wavesurfer.getDuration();

  //   setInterval(function () {
  //     var currentTime = wavesurfer.getCurrentTime();

  //     document.querySelector('#timeRecord').textContent = toHHMMSS(currentTime) + "/" + toHHMMSS(durationTime);

  //     if (currentTime == durationTime){
  //       $(".your-record-audio-pause").addClass("d-none");
  //       $(".your-record-audio-play").removeClass("d-none");
  //     }
  //   }, durationTime);

  //   wavesurfer.playPause();
  // });

  // $(".your-record-audio-pause").on('click', function(){
  //   $(".your-record-audio-pause").addClass("d-none");
  //   $(".your-record-audio-play").removeClass("d-none");

  //   var durationTime = wavesurfer.getDuration();

  //   setInterval(function () {
  //     var currentTime = wavesurfer.getCurrentTime();

  //     document.querySelector('#timeRecord').textContent = toHHMMSS(currentTime) + "/" + toHHMMSS(durationTime);
  //   }, durationTime);

  //   wavesurfer.playPause();
  // });

  var timePre;
  var timePost;
  var pre;
  var post;

  function startTimerPre() {
    var timer = timePre, minutes, seconds;
    pre = setInterval(function () {
      minutes = parseInt(timer / 60, 10)
      seconds = parseInt(timer % 60, 10);

      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;

      document.querySelector('#timePrepaire').textContent = minutes + ":" + seconds;

      if (--timer < 0) {
        $("#time-prepaire").addClass("d-none");
        $("#time-progess").removeClass("d-none");


        $('#btnStart').addClass("d-none");
        $('#btnStop').removeClass("d-none");
        clearInterval(pre);
        recorder.start();
        startTimerPost();
      }
    }, 1000);
  };

  function startTimerPost() {
    var timer = timePost, minutes, seconds;
    post = setInterval(function () {
      minutes = parseInt(timer / 60, 10)
      seconds = parseInt(timer % 60, 10);

      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;

      document.querySelector('#timeProgess').textContent = minutes + ":" + seconds;

      if (--timer < 0) {
        $("#time-prepaire").addClass("d-none");
        $("#time-progess").addClass("d-none");
        $('#time-out').removeClass("d-none");

        $('#btnStop').addClass("d-none");
        $('#btnAgain').removeClass("d-none");
        $('#btnNext').removeClass("d-none");

        $('.origin-audio').removeClass("d-none");
        $('.record-audio').removeClass("d-none");

        // wavesurferorigin.load('/assets/2018collection_55-3d39adaf2350f3b47b0021add3cdc52b0e946a5382dcf66ea06f71c868f1e8a0.mp3');
        // wavesurfer.load('/assets/2018collection_55-3d39adaf2350f3b47b0021add3cdc52b0e946a5382dcf66ea06f71c868f1e8a0.mp3');

        clearInterval(post);
        recorder.stop();
      }
      else {}
    }, 1000);
  };

  function start_Record(){
    recorder.start();
    document.querySelector('#timePrepaire').textContent = "00:" + timePre;
    document.querySelector('#timeProgess').textContent = "00:" + timePost;

    $('#btnStart').addClass("d-none");
    $('#btnStop').removeClass("d-none");

    $('#time-prepaire').addClass("d-none");
    $('#time-progess').removeClass("d-none");
    $('#time-out').addClass("d-none");

    clearInterval(pre);
    clearInterval(post);
    startTimerPost();
    
  };

  function stop_Record(){
    document.querySelector('#timePrepaire').textContent = "00:" + timePre;
    document.querySelector('#timeProgess').textContent = "00:" + timePost;

    $('#btnStop').addClass("d-none");

    $('#btnAgain').removeClass("d-none");
    $('#btnNext').removeClass("d-none");

    $('#time-prepaire').addClass("d-none");
    $('#time-progess').addClass("d-none");
    $('#time-out').removeClass("d-none");

    $('.origin-audio').removeClass("d-none");
    $('.record-audio').removeClass("d-none");

    // wavesurferorigin.load('/assets/2018collection_55-3d39adaf2350f3b47b0021add3cdc52b0e946a5382dcf66ea06f71c868f1e8a0.mp3');
    // wavesurfer.load('/assets/2018collection_55-3d39adaf2350f3b47b0021add3cdc52b0e946a5382dcf66ea06f71c868f1e8a0.mp3');

    clearInterval(pre);
    clearInterval(post);
    recorder.stop();

  };

  function reload_Record() {
    document.querySelector('#timePrepaire').textContent = "00:" + timePre;
    document.querySelector('#timeProgess').textContent = "00:" + timePost;

    $('#btnAgain').addClass("d-none");
    $('#btnNext').addClass("d-none");
    $('#btnStart').removeClass("d-none");

    $('#time-prepaire').removeClass("d-none");
    $('#time-progess').addClass("d-none");
    $('#time-out').addClass("d-none");

    $('.origin-audio').addClass("d-none");
    $('.record-audio').addClass("d-none");

    clearInterval(pre);
    clearInterval(post);
    startTimerPre();
  };

  function next_Record() {
    newHTML = $("p#content" + readCounter).text();
    $('#next-read' + (readCounter - 1)).hide();
    $('#next-read' + readCounter).show();
    // $("p#content" + (readCounter - 1)).hide();
    // $("p#content" + readCounter).show();
    // $('#paragrap' + (readCounter - 1)).hide();
    // $('#paragrap' + readCounter).show();
    readCounter ++;
    
    clearInterval(pre);
    clearInterval(post);

    timePre = 40;
    timePost = 40;

    document.querySelector('#timePrepaire').textContent = "00:" + timePre;
    document.querySelector('#timeProgess').textContent = "00:" + timePost;

    startTimerPre();
  };

  function init() {
    clearInterval(pre);
    clearInterval(post);

    timePre = 40;
    timePost = 40;

    document.querySelector('#timePrepaire').textContent = "00:" + timePre;
    document.querySelector('#timeProgess').textContent = "00:" + timePost;

    startTimerPre();
  };
  init();
});


