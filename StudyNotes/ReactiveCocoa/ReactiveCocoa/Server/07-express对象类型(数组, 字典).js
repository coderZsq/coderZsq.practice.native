var underscore = require('underscore');

var arr = [1, 2, 3, 'A'];

arr.push('B');
arr.pop();
arr.splice(1, 1);
delete arr[2];
arr.splice(3, 0, 'C');
console.log(arr);

// var bool = arrContain(arr, 3);

var bool = underscore.contains(arr, 1);
console.log(bool);

var dict = {'name' : 'cas', 'age': 18};
dict.money = 999;
dict['age'] = 20;
delete dict['age'];
delete dict.name;
console.log(dict);

function arrContain(arr, value) {
    var count = arr.length;
    for (var i = 0; i < count; i++) {
        var obj = arr[i];
        if (obj === value) {
            return true;
        } else {
            continue;
        }
    }
    return false;
}

var express = require('express');

var app = express();

app.get('/', function(req, res) {
    res.send(dict);
});

app.listen(8080);