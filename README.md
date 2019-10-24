# Docker for NuxtJs Universal (SSR) use + Express Js start use PM2

> Configuration for `Staging` & `Production` purpose



Sample domain name:

1. staging.domain.com
2. production.domain.com

so you must edit hosts file on local pc or server to cconfigure domain name for testing:

> Windows 8.1/10 `C:\Windows\System32\drivers\etc\hosts`
> Linux/MacOS `/etc/hosts`

``` bash
127.0.0.1 staging.domain.com
127.0.0.1 production.domain.com
```

## Configuration for package.json

Before build remove `.nuxt` directory, use `rimraf` for handling remove directory not from docker entrypoint

> Install `rimraf`, `dotenv`

``` bash
npm i rimraf dotenv
```

> Information for `staging` & `production` must have, you can view on sample app on `public_html`:

1. nuxt.config.staging.js
2. nuxt.config.production.js

Edit `nuxt.config.js` and adding at the top file some code for get variables use `dotenv` on `.env` file.

``` javascript
const dotenv = require('dotenv')

dotenv.config()

module.exports = {
  mode: 'universal',
  ...

}
```

and modify package.json file on `scripts`.

``` javascript
...
 "scripts": {
    "clean": "rimraf .nuxt",
    "dev": "cross-env NODE_ENV=development nodemon server/index.js --watch server",
    "build-staging": "npm run clean && nuxt build -c nuxt.config.staging.js",
    "build-production": "npm run clean && nuxt build -c nuxt.config.production.js",
    "start": "pm2 start ecosystem.config.js --only nuxt-app && pm2 logs",
    "generate": "nuxt generate"
  }
...
```

## PM2 ecosystem config

Remember for your express script server location depending on where you put the file.

`script: "./server/index.js"` or `script: "./server.js"`

> Same location save with project application

``` javascript
module.exports = {
  apps : [{
    name : "project-name",
    exec_mode : "cluster",
    instances : 2,
    script: "./server/index.js",
    watch: true,
    env: {
      "HOST": "0.0.0.0",
      "PORT": 3000,
      "NODE_ENV": "production"
    }
  }]
};
```
