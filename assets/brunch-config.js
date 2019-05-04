exports.config = {
  files: {
    javascripts: {
      joinTo: {
       "js/front.js": /^(js\/front)|(node_modules)/,
       "js/admin.js": /^(js\/admin)|(node_modules)/,
       "js/vendor/admin.js": /^(js\/vendor\/admin)/,
       "js/vendor/front.js": /^(js\/vendor\/front)/
      },
      order: {
        before: [
          "js/vendor/admin/jquery.js",
          "js/vendor/admin/tether.js",
          "js/vendor/admin/bootstrap.js",
          "js/vendor/front/jquery.min.js",
          "js/vendor/front/popper.min.js",
          "js/vendor/front/bootstrap.min.js"
        ]
      }
    },
    stylesheets: {
      joinTo: {
        "css/front.css": "css/front/app.scss",
        "css/admin.css": "css/admin/*.css"
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/, /node_modules/]
    }
  },

  modules: {
    autoRequire: {
      "js/admin.js": ["js/admin/app"],
      "js/front.js": ["js/front/app"]
    }
  },

  npm: {
    enabled: true
  }
};
