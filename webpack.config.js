var webpack = require('webpack');

module.exports = {
  entry: './static/js/app.js',
  output: {
    path: __dirname + '/static/js',
    filename: 'app.min.js'
  },
  module: {
    loaders: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack'
    }]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({})
  ]
};
