//
// Torrents
// (~˘▾˘)~
//
// All things torrents.

let client;


// Create the torrent client
// and download the torrent metadata.
function loadTorrent(identifier) {
  if (!client) {
    client = new WebTorrent();
  }

  return new Promise((resolve, reject) => {
    const torrent = client.get(identifier);

    torrent
      ? resolve(torrent)
      : client.add(identifier, {}, resolve);
  });
}


// Get a list of all the files in a torrent.
function torrentTree(context) {
  const srcData = JSON.parse(context.sourceData);

  return loadTorrent(srcData.identifier).then(torrent => {
    return Object.assign({}, context, {
      filePaths: torrent.files.map(file => file.path)
    });
  });
}


// Get the Blob URL of a file in a torrent.
function torrentFile(identifier, filePath) {
  const torrent = loadTorrent(identifier);
  const file = torrent.files.find(file => {
    return file.path === filePath;
  });

  if (file) {
    return new Promise((resolve, reject) => {
      const timeoutId = setTimeout(() => {
        if (self.app && self.app.ports.setDownloading) {
          self.app.ports.setDownloading(true)
        }
      }, 2500);

      file.getBlobURL((err, url) => {
        clearTimeout(timeoutId);

        if (self.app && self.app.ports.setDownloading) {
          self.app.ports.setDownloading(false);
        }

        err ? reject(err) : resolve(url);
      });
    });

  } else {
    return Promise.resolve("FILE_NO_LONGER_AVAILABLE");

  }
}
