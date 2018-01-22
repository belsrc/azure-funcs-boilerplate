# Azure Function Boilerplate

_Disclaimer: Currently untested, use at your own risk...for now_

Simple boilerplate for making Azure Functions.
Uses Babel to transpile to Node 6.5 code which is currently the highest Node version available and
Rollup to bundle source files into a single file.

Put all code into ```/src/``` broken up however you want and run ```npm run build``` or ```make``` to transpile and
bundle the code to ```./index.js```, ready for deploying.

### npm run
| cmd            | desc                                                          |
|:--------------:|---------------------------------------------------------------|
| ```clean```    | Runs Prettier and eslint --fix                                |
| ```test```     | Runs units tests with ava                                     |
| ```security``` | Checks for package security issues using nsp                  |
| ```rollup```   | Runs Rollup                                                   |
| ```update```   | Interactive package updating via npm-check                    |
| ```build```    | Runs ```security```, ```test```, ```clean``` and ```rollup``` |

### License

Copyright (c) 2017 Bryan Kizer

azure-func-boilerplate is licensed under the MIT license. [See LICENSE file](LICENSE).


#### Resources
  * https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-node
  * https://docs.microsoft.com/en-us/azure/azure-functions/functions-host-json
  * https://docs.microsoft.com/en-us/azure/azure-functions/functions-continuous-deployment
  * https://github.com/projectkudu/kudu/wiki/Customizing-deployments
