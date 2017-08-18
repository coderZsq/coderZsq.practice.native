var path = require('path');

var baseLogPath = path.resolve(__dirname, '../logs')

var errorPath = "/error";
var errorFileName = "error";
var errorLogPath = baseLogPath + errorPath + "/" + errorFileName;

var responsePath = "/response";
var responseFileName = "response";
var responseLogPath = baseLogPath + responsePath + "/" + responseFileName;

module.exports = {
    "appenders": [{
            "category": "errorLogger",
            "type": "dateFile",
            "filename": errorLogPath,
            "alwaysIncludePattern": true,
            "pattern": "-yyyy-MM-dd-hh.log",
            "path": errorPath
        },
        {
            "category": "resLogger",
            "type": "dateFile",
            "filename": responseLogPath,
            "alwaysIncludePattern": true,
            "pattern": "-yyyy-MM-dd-hh.log",
            "path": responsePath
        }
    ],
    "levels": {
        "errorLogger": "ERROR",
        "resLogger": "ALL"
    },
    "baseLogPath": baseLogPath
}
