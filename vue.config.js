module.exports = {
  devServer: {
    proxy: "https://app.mxtime.se/",
  },

  pwa: {
    name: "MX-Time",
    themeColor: "#1988c9",
    workboxOptions: {
      skipWaiting: true,
    },
  },

  publicPath: '',

  pluginOptions: {
    cordovaPath: 'src-cordova'
  }
};
