function User(age, name) {
    this.age = age;
    this.name = name;
    this.eat = function() {
        console.log('吃东西');
    };
}

module.exports = User;