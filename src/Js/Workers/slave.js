//
// Slave worker
// (◡ ‿ ◡ ✿)
//
// This worker is responsible for executing CPU-heavy tasks with the help of Elm.

importScripts("/vendor/package.js");
importScripts("/lib/processing.js");
importScripts("/lib/torrents.js");
importScripts("/lib/urls.js");
importScripts("/slave.js");


const app = Elm.Slave.worker();


//
// Incoming & Outgoing

self.onmessage = event => {
  app.ports.incoming.send(event.data);
};


app.ports.outgoing.subscribe(aura => {
  self.postMessage(aura);
});



//
// Processing ports

app.ports.makeTorrentTree.subscribe(context => {
  torrentTree(context).then(app.ports.receiveTorrentTree.send);
});


app.ports.requestTags.subscribe(context => {
  processContext(context).then(app.ports.receiveTags.send);
});
