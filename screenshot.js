var
  log = function(x){console.log(x)},
  system = require('system'),
  finish = (function(obj){
    log(JSON.stringify(obj));
    phantom.exit();
  })
  ;

if(system.args.length != 3){
  finish({
    error: 'Wrong number of `system.args` (!=4)'
  });
}

var page = require('webpage').create();

page.onError = (function(){});
page.onConsoleMessage = (function(){});
page.onAlert = (function(){});
page.onConfirm = (function(){return(true);});
page.onPrompt = (function(){return("hi");});

var res = '1024x768';

page.viewportSize = {
  width: res.split('x').shift(),
  height: res.split('x').pop(),
};

page.clipRect = {
  top: 0,
  left: 0,
  width: res.split('x').shift(),
  height:res.split('x').pop(),
};

page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36';

var
  url = system.args[1],
  outfile = system.args[2]
  ;

page.open(url,function(status){
  if(status != 'success'){
    finish({
      error: 'Failed to fetch the url: ' + url
    });
  }

  page.render(outfile);

  finish({
    url: url,
    outfile: outfile,
  })
});

