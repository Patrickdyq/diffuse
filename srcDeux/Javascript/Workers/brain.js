//
// Brain
// 🧠
//
// This worker is responsible for everything non-UI.

importScripts("/brain.js");


const app = Elm.Brain.init();


//
// Incoming <> Outgoing

// self.onmessage = event => {
//   app.ports.incoming.send(event.data);
// };
//
// app.ports.outgoing.subscribe(aura => {
//   self.postMessage(aura);
// });
