function write(fd, ch) {
  self.postMessage({fd: fd, ch: ch});
}

self.addEventListener('message', function(e) {
  console.log("received:" + e.data);
  e.data.split("").forEach(function(ch) {
      Module.stdin_buf.push(ch.charCodeAt(0));
  });
  console.log("stdin buf is:");
  console.log(Module.stdin_buf);
}, false);

/*
// In order to watch JS event queue triggerred.
// Each received key event is blocked until this function shows message.
function showJSEventQueueFire() {
  console.log("Event queue is being processed");
  setTimeout(showJSEventQueueFire, 0);
}
setTimeout(showJSEventQueueFire,0);
*/

var Module = {
  preRun: [function() {
    FS.init(null, function(ch) {write("stdout", ch);}, function(ch) {write("stderr", ch)});
  }],
  arguments: ["xv6.img"],
  stdin_buf: []
};

importScripts('sim.js');
