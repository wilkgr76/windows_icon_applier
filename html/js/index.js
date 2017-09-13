const {dialog} = require('electron').remote
var DecompressZip = require('decompress-zip');
const path = require('path');
var rimraf = require('rimraf');
var glob = require("glob")
// var walk = require('walk');
var ws = require('windows-shortcuts');

// console.log = function(input) {
//   console.warn(input)
//   document.getElementById("log").value += input + "\n"
//   var textarea = document.getElementById('log');
//   textarea.scrollTop = textarea.scrollHeight;
// }

const dir_root = `${__dirname}\\..`

function getFile() {
  applyPack(dialog.showOpenDialog({
    "title": "Choose icon pack",
    "defaultPath": __dirname,
    "filters": [{
      "name": "Icon Pack",
      "extensions": ["zip"]
    }]
  }))
}

function applyPack(ZIPfile) {
  console.log(ZIPfile)
  rimraf.sync(dir_root + "/icons/")
  var unzipper = new DecompressZip(ZIPfile[0]);
  unzipper.extract({
    path: dir_root + '/icons/',
    filter: function (file) {
      return file.type !== "SymbolicLink";
    }
  });
  unzipper.on('error', function (err) {
    console.error(err);
  });

  unzipper.on('extract', function (log) {
    console.log('Finished extracting');

    var gpath = path.resolve(__dirname,"../../original_icons/");
    gpath = gpath.replace(/\\/g,"/") + "/**/*.lnk"
    console.log("Path: " + gpath);

    glob(gpath, function (er, files) {
      console.log("Glob!")
      if(er) {
        console.log(er)
      }
      if(files) {
        console.log(files);
      }
    })
  });

  unzipper.on('progress', function (fileIndex, fileCount) {
    document.getElementById("extracting").max = fileCount;
    document.getElementById("extracting").value = fileIndex + 1;
    console.log('Extracted file ' + (fileIndex + 1) + ' of ' + fileCount);
  });


  // var walker  = walk.walk('../original_icons', {
  //   followLinks: false
  // });
  //
  // walker.on('file', function(root, stat, next) {
  //   // Add this file to the list of files
  //   files.push(root + '/' + stat.name);
  //   next();
  // });
  // walker.on('end', function() {
  //   parseFiles(files);
  //   // console.log(files);
  // });
}

function parseFiles(files) {
  for(i=0;i<files.length;i++) {
    console.warn(files[i])
    // ws.query(files[i],console.warn)
  }
}

document.getElementById("apply").addEventListener("click",getFile);