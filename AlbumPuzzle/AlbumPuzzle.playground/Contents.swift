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

example(of: "ignoreElements") {
    
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes.ignoreElements().subscribe { _ in
        print("You're out")
        }.addDisposableTo(disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    
    strikes.onCompleted()
}

example(of: "elementAt") {
    
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes.elementAt(2).subscribe(onNext: { _ in
        print("You're out")
    }).addDisposableTo(disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
}

example(of: "filter") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6).filter { integer in
        integer % 2 == 0
        }.subscribe(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
}

example(of: "skip") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C", "D", "E", "F").skip(3).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

example(of: "skipWhile") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(2, 2, 3, 4, 4).skipWhile { integer in
        integer % 2 == 0
        }.subscribe(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
}

example(of: "skipUntil") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.skipUntil(trigger).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    
    trigger.onNext("X")
    
    subject.onNext("C")
}

example(of: "take") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6).take(3).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

example(of: "takeWhileWithIndex") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(2, 2, 4, 4, 6, 6).takeWhileWithIndex { integer, index in
        integer % 2 == 0 && index < 3
        }.subscribe(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
}

example(of: "takeUntil") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.takeUntil(trigger).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    subject.onNext("1")
    subject.onNext("2")
    
    trigger.onNext("X")
    
    subject.onNext("3")
}

/*
 
someObservable.takeUntil(self.rx.deallocated).subscribe(onNext: {
    print($))
})
 
 */

example(of: "distinctUntilChanged") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "A", "B", "B", "A").distinctUntilChanged().subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

example(of: "distinctUntilChanged(_:)") {
    
    let disposeBag = DisposeBag()
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310).distinctUntilChanged { a, b in
        guard let aWords = formatter.string(from: a)?.components(separatedBy: " "), let bWords = formatter.string(from: b)?.components(separatedBy: " ") else { return false }
        
        var containsMatch = false
        for aWord in aWords {
            for bWord in bWords {
                if aWord == bWord {
                    containsMatch = true
                    break
                }
            }
        }
        return containsMatch
        }.subscribe(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
}

example(of: "Sharing subscription") {
    
    var start = 0
    func getStartNumber() -> Int {
        start += 1
        return start
    }
    
    let numbers = Observable<Int>.create { observer in
        
        let start = getStartNumber()
        observer.onNext(start)
        observer.onNext(start+1)
        observer.onNext(start+2)
        observer.onCompleted()
        return Disposables.create()
    }
    
    numbers.subscribe(
        onNext: { el in
            print("element [\(el)]")
        },
        onCompleted: {
            print("---------------")
        }
    )
    
    numbers.subscribe(
        onNext: { el in
            print("element [\(el)]")
        },
        onCompleted: {
            print("---------------")
        }
    )
}

example(of: "Sharing subscription Fix") {
        
    var start = 0
    func getStartNumber() -> Int {
        start += 1
        return start
    }
    
    let numbers = Observable<Int>.create { observer in
        
        let start = getStartNumber()
        observer.onNext(start)
        observer.onNext(start+1)
        observer.onNext(start+2)
        observer.onCompleted()
        return Disposables.create()
    }
    
    let shareNumbers = numbers.share()
    
    shareNumbers.subscribe(
        onNext: { el in
            print("element [\(el)]")
        },
        onCompleted: {
            print("---------------")
        }
    )
    
    shareNumbers.subscribe(
        onNext: { el in
            print("element [\(el)]")
        },
        onCompleted: {
            print("---------------")
        }
    )
}