//
function getMixiCheckKey() {
  var pattern = /k=([a-zA-Z0-9]+)$/;
  var nodeList = content.document.getElementsByTagName('a');
  var regex = new RegExp(pattern);
  for(var i=0; i < nodeList.length; i++){
    if(nodeList[i].href.match(regex)){
      var key = nodeList[i].href.match(regex)[1];
    }
  }
  return key;
}

//
function mixicheckChangeState() {
  var tbutton = document.getElementById('mixicheck-toolbarbutton');
  tbutton.disabled = true;
  var key = getMixiCheckKey();
  if (key) {
  	tbutton.disabled = false;
    //break;
  }
}

// 
function mixicheckInit(e) {
    var contentArea = document.getElementById('appcontent');
    contentArea.addEventListener('select', mixicheckChangeState, false);
    contentArea.addEventListener('load', mixicheckChangeState, true);
}

// 
//window.addEventListener('load', mixicheckInit, false);
