//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "toArray") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C").toArray().subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

example(of: "map") {
    
    let disposeBag = DisposeBag()
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(123, 4, 56).map {
        formatter.string(from: $0)
    }.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

example(of: "mapWithIndex") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6).mapWithIndex { integer, index in
        index > 2 ? integer * 2 : integer
    }.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

struct Student {
    var score: Variable<Int>
}

example(of: "flatMap") {
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: Variable(80))
    let charlotte = Student(score: Variable(90))
    
    let student = PublishSubject<Student>()
    
    student.asObservable().flatMap {
        $0.score.asObservable()
    }.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    student.onNext(ryan)
    ryan.score.value = 85
    student.onNext(charlotte)
    ryan.score.value = 95
    charlotte.score.value = 100
}

example(of: "flatMapLatest") {
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: Variable(80))
    let charlotte = Student(score: Variable(90))
    
    let student = PublishSubject<Student>()
    
    student.asObservable().flatMapLatest {
        $0.score.asObservable()
    }.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    student.onNext(ryan)
    ryan.score.value = 85
    student.onNext(charlotte)
    ryan.score.value = 95
    charlotte.score.value = 100
}

