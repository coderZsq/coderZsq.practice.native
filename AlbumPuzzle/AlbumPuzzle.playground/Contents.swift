//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "just, of, from") {
    
    let one = 1
    let two = 2
    let three = 3
    
    let observable: Observable<Int> = Observable<Int>.just(one)
    
    let observable2 = Observable.of(one, two, three)
    
    let observable3 = Observable.of([one, two, three])
    
    let observable4 = Observable.from([one, two, three])
}

example(of: "subscribe") {
    
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable.of(one, two, three)
    
    observable.subscribe { event in
        print(event)
    }
    
    observable.subscribe { event in
        
        if let element = event.element {
            print(element)
        }
    }
    
    observable.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    
    let observable = Observable<Void>.empty()
    
    observable.subscribe(
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("Completed")
        }
    )
}

example(of: "never") { 
    
    let observable = Observable<Any>.never()
    
    observable.subscribe(
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("Completed")
        }
    )
}


example(of: "range") { 
    
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable.subscribe(onNext: { i in
        let n = Double(i)
        let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
            2.23606).rounded())
        print(fibonacci)
    })
}

example(of: "dispose") { 
    
    let observable = Observable.of("A", "B", "C")
    let subscription = observable.subscribe { event in
        print(event)
    }
    
    subscription.dispose()
}

example(of: "DisposeBag") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C").subscribe {
        print($0)
    }.addDisposableTo(disposeBag)
}

example(of: "create") { 
    
    enum MyError: Error {
        case anError
    }
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        observer.onNext("1")
        observer.onError(MyError.anError)
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }.subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") }
    ).addDisposableTo(disposeBag)
}

example(of: "deferred") { 
    
    let disposeBag = DisposeBag()
    var flip = false
    let factory: Observable<Int> = Observable.deferred {
        flip = !flip
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }
    
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        }).addDisposableTo(disposeBag)
        print()
    }
}

example(of: "PublishSubject") { 
    
    let subject = PublishSubject<String>()
    
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in
        print(string)
    })
    
    subject.on(.next("1"))
    subject.onNext("2")
    
    let subscriptionTwo = subject.subscribe { event in
        print("2)", event.element ?? event)
    }

    subject.onNext("3")
    
    subscriptionOne.dispose()
    
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")
    
    subscriptionTwo.dispose()
    
    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print("3)", $0.element ?? $0)
    }.addDisposableTo(disposeBag)
    
    subject.onNext("?")
}

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

example(of: "BehaviorSubject") { 
    
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print(label: "1)", event: $0)
    }.addDisposableTo(disposeBag)
    
    subject.onNext("X")
    subject.onError(MyError.anError)
    
    subject.subscribe {
        print(label: "2)", event: $0)
    }.addDisposableTo(disposeBag)
}

example(of: "ReplaySubject") { 
    
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    
    subject.subscribe {
        print(label: "1)", event: $0)
    }.addDisposableTo(disposeBag)

    subject.subscribe {
        print(label: "2)", event: $0)
    }.addDisposableTo(disposeBag)
    
    subject.onNext("4")
    
    subject.subscribe {
        print(label: "3)", event: $0)
    }.addDisposableTo(disposeBag)
    
    subject.onError(MyError.anError)
    subject.dispose()
}

example(of: "Variable") { 
    
    var variable = Variable("Initial value")
    let disposeBag = DisposeBag()
    
    variable.value = "New initial value"

    variable.asObservable().subscribe {
        print(label: "1)", event: $0)
    }.addDisposableTo(disposeBag)
    
    variable.value = "1"
    
    variable.asObservable().subscribe {
        print(label: "2)", event: $0)
    }.addDisposableTo(disposeBag)

    variable.value = "2"
}

/*
 
 variable.value.onError(MyError.anError)
 variable.asObservable().onError(MyError.anError)
 variable.value = MyError.anError
 variable.value.onCompleted()
 variable.asObservable().onCompleted()
 
 */

