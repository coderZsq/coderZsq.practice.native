var underscore = require('underscore');

function User(name, age){
    this.name = name;
    this.age = age;
    this.eat = function() {
        console.log('吃东西');
    }
}

var user = new User('Cas', 26);
var user2 = new User('Cas', 26);
var user3 = new User('Cas', 26);
var arr = [user, user2];
var bool = underscore.contains(arr, user3);
console.log(bool);
user.eat();
console.log(arr);