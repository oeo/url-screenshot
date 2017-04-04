# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2
log = (x...) -> try console.log x...

_ = require('wegweg')({
  globals: no
  shelljs: no
})

path = require 'path'
cp = require 'child_process'

phantom_js = require 'phantomjs-prebuilt'
bin_path = phantom_js.path

module.exports = screenshot = ((opt,cb) ->
  if !opt.url then return cb new Error "`opt.url` required"

  opt.outfile ?= "/tmp/#{_.uuid}.png"
  opt.outfile = _.resolve opt.outfile

  child_args = [
    path.join(__dirname,'screenshot.js')
    opt.url
    opt.outfile
  ]

  await cp.execFile bin_path, child_args, defer err,stdout,stderr
  if err then return cb err

  try
    response = JSON.parse stdout.trim()
  catch
    return cb new Error 'Failed to decode response: ' + stdout.trim()

  if response.error then return cb new Error(response.error)

  cb null, response.outfile
)

##
if !module.parent
  log /DEVEL/

  ss_opt = {
    url: 'https://www.google.com'
    outfile: '/tmp/google.png'
  }

  await screenshot ss_opt, defer e,r
  log e
  log r
  process.exit 0

