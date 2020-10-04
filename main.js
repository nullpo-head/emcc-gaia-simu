var term;

var worker = new Worker('xv6.js');

worker.addEventListener('message', function(e) {
  var ch = String.fromCharCode(e.data.ch);
  if (ch == "\n") {
    ch = "\r\n";
  }
  term.write(ch);
}, false);

window.addEventListener('load', function() {

  term = new Terminal({
      cols: 80,
      rows: 24,
      useStyle: true,
      cusorBlink: true,
      fontFamily: "DejaVu Sans Mono, Liberation Mono, monospace",
      fontSize: 11
  });

  term.onData(function(str) {
    worker.postMessage(str);
  });

  term.onTitleChange(function(title) {
    document.title = title;
  });

  term.open(document.querySelector("#term"));

}, false);

