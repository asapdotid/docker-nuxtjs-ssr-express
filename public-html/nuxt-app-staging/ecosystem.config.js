module.exports = {
  apps : [{
    name : "nuxt-app",
    exec_mode : "cluster",
    instances : "2",
    script: "./server/index.js",
    watch: true,
    env: {
      "HOST": "0.0.0.0",
      "PORT": 3000,
      "NODE_ENV": "production"
    }
  }]
};
