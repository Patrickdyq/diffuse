importScripts("/vendor/blockstack.js");


//
// Construct

self.postMessage({ action: "CONSTRUCT_SUCCESS" });



//
// Incoming messages (TODO)

self.onmessage = event => {
  switch (event.data.action) {
    case "GET": return get(event.data.data);
    case "SET": return set(event.data.data);
  }
};



//
// Get

function get(data) {
  blockstack.getFile(data.key).then(
    res => self.postMessage({ action: "GET_SUCCESS", data: res }),
    err => self.postMessage({ action: "GET_SUCCESS", data: null })
  );
}



//
// Set

function set(data) {
  blockstack.putFile(data.key, data.json).then(
    res => self.postMessage({ action: "SET_SUCCESS" }),
    err => self.postMessage({ action: "SET_FAILURE", data: err })
  );
}
