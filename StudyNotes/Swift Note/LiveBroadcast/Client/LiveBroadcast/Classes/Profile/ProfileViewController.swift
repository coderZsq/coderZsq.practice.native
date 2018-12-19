//
//  ProfileViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

extension ProfileViewController {
    
    fileprivate func play() {
        let url = URL(string: "http://59.110.27.24:8080/live/demo.m3u8")
        let player = AVPlayer(url: url!)
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
        player.play()
    }
    
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    fileprivate lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment1()
        segment2()
        segment3()
        segment4()
        segment5()
    }
    
}

extension ProfileViewController {
    
    fileprivate func segment5() {
        let subject = BehaviorSubject(value: "a")
        subject.subscribe { (event) in
            print(event, #line)
            }.dispose()
        subject.onNext("b")
    }
    
    fileprivate func segment4() {
        Observable.of(1, 2, 3, 4).map { (num) -> Int in
            return num * num
            }.subscribe { (event) in
                print(event, #line)
            }.disposed(by: bag)
        
        struct Student {
            var score: Variable<Double>
        }
        let stu1 = Student(score: Variable(80))
        let stu2 = Student(score: Variable(100))
        let studentVariable = Variable(stu1)
        //        studentVariable.asObservable().flatMap { (stu) -> Observable<Double> in
        //            return stu.score.asObservable()
        //            }.subscribe { (event) in
        //                print(event, #line)
        //        }.disposed(by: bag)
        //        stu1.score.value = 1000
        //        studentVariable.value = stu2
        //        stu2.score.value = 0
        studentVariable.asObservable().flatMapLatest { (stu) -> Observable<Double> in
            return stu.score.asObservable()
            }.subscribe { (event) in
                print(event, #line)
            }.disposed(by: bag)
        studentVariable.value = stu2
        stu2.score.value = 0
        stu1.score.value = 1000
    }
    
    fileprivate func segment3() {
        let publishSub = PublishSubject<String>()
        publishSub.onNext("coderZsq - 1")
        publishSub.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        publishSub.onNext("coderZsq - 2")
        
        let replaySub = ReplaySubject<String>.createUnbounded()//create(bufferSize: 2)
        replaySub.onNext("a")
        replaySub.onNext("b")
        replaySub.onNext("c")
        replaySub.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        replaySub.onNext("d")
        
        let behaviorSub = BehaviorSubject(value: "a")
        behaviorSub.onNext("b")
        behaviorSub.onNext("c")
        behaviorSub.onNext("d")
        behaviorSub.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        behaviorSub.onNext("e")
        behaviorSub.onNext("f")
        behaviorSub.onNext("g")
        
        let variable = Variable("a")
        variable.value = "b"
        variable.asObservable().subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        variable.value = "c"
        variable.value = "d"
    }
    
    func segment2() {
        let neverO = Observable<String>.never()
        neverO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let emptyO = Observable<String>.empty()
        emptyO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let justO = Observable.just("coderZsq")
        justO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let ofO = Observable.of("a", "b", "c")
        ofO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let fromO = Observable.from([1, 2, 3, 4, 5])
        fromO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        func createObserable() -> Observable<Any> {
            return Observable.create({ (observer) -> Disposable in
                observer.onNext("coderZsq")
                observer.onNext("18")
                observer.onNext("1.88")
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        let createO = createObserable()
        createO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        func myJustObserable(element: String) -> Observable<String> {
            return Observable.create({ (observer) -> Disposable in
                observer.onNext(element)
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        let myJustO = myJustObserable(element: "coderZsq")
        myJustO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let rangeO = Observable.range(start: 1, count: 10)
        rangeO.subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
        
        let repeatO = Observable.repeatElement("hello world")
        repeatO.take(5).subscribe { (event) in
            print(event, #line)
            }.disposed(by: bag)
    }
    
    fileprivate func segment1() {
        button1.rx.tap.subscribe { (event) in
            print("按钮1 发生了点击")
            }.disposed(by: bag)
        
        button2.rx.tap.subscribe { (event) in
            print("按钮2 发生了点击")
            }.disposed(by: bag)
        
        //        textField1.rx.text.subscribe { (event) in
        //            print(event.element!!)
        //        }.disposed(by: bag)
        //
        //        textField2.rx.text.subscribe { (event) in
        //            print(event.element!!)
        //        }.disposed(by: bag)
        
        textField1.rx.text.subscribe(onNext: { (element) in
            print(element!, #line)
        }).disposed(by: bag)
        
        textField2.rx.text.subscribe(onNext: { (element) in
            print(element!, #line)
        }).disposed(by: bag)
        
        
        //        textField1.rx.text.subscribe(onNext: { (element) in
        //            self.label1.text = element
        //        }).disposed(by: bag)
        //
        //        textField2.rx.text.subscribe(onNext: { (element) in
        //            self.label2.text = element
        //        }).disposed(by: bag)
        
        textField1.rx.text.bind(to: label2.rx.text).disposed(by: bag)
        textField2.rx.text.bind(to: label1.rx.text).disposed(by: bag)
        
        //        textField1.rx.observe(String.self, "text").subscribe(onNext: { (element) in
        //            print(element!)
        //        }).disposed(by: bag)
        
        textField1.rx.observe(CGRect.self, "frame").subscribe(onNext: { (element) in
            print(element!, #line)
        }).disposed(by: bag)
        
        UIScrollView().rx.contentOffset.subscribe({(point) in
            print(point)
        }).disposed(by: bag)
    }
    
}

extension ProfileViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
