var exec = require('cordova/exec');

var CropImage = {
  registered: false,
  startWork: function(photomessage, successCallback) {
    exec(successCallback, CropImage.failureFn, 'CropImage', 'startWork', [photomessage]);
  },

  failureFn: function() {
    console.log('fail to register CropImage');
  }
}

module.exports = CropImage;