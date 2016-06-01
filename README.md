# url-screenshot

# install

using [npm](https://npmjs.org)

```
npm i url-screenshot --save
```

# example

``` coffeescript
screenshot = require 'url-screenshot'

ss_opt = {
	url: 'https://www.google.com'
	outfile: '/tmp/google.png'
}

await screenshot ss_opt, defer e,outfile

console.log e
console.log outfile

process.exit 0
```


