(function(exports) {
    exports.sum = function(a, b) {
        return a + b;
    };
    exports.minus = function(a, b) {
        return a - b;
    };
    exports.age = 18;
    SQAppId = [NSBundle mainBundle].bundleIdentifier;
    SQRootVc = function() {
        return UIApp.keyWindow.rootViewController;
    };
    SQDocPath = NSSearchPathForDirectoriesInDomains(NSDocmentDirectory, NSUserDomainMask, YES)[0];
})(exports);