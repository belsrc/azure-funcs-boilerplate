const fs = require('fs');
const path = require('path');
const babel = require('rollup-plugin-babel');
const resolve = require('rollup-plugin-node-resolve');
const pkg = JSON.parse(fs.readFileSync(path.resolve('./package.json'), 'utf-8'));
const external = Object.keys(pkg.dependencies || {});

//https://github.com/rollup/rollup-plugin-node-resolve/issues/77
module.exports = {
  input: 'src/index.js',
  output: {
    file: 'index.js',
    format: 'cjs',
    name: 'functionBundle',
  },
  plugins: [
    resolve(), babel({ exclude: 'node_modules/**' }), external,
  ],
};
