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
        
        button1.rx.tap.subscribe { (event) in
            print("按钮1 发生了点击")
        }.disposed(by: bag)
        
        button1.rx.tap.subscribe { (event) in
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
    
        let createO = createObserable()
        createO.subscribe { (event) in
            print(event, #line)
        }.disposed(by: bag)
    }
    
}

extension ProfileViewController {
    
    fileprivate func createObserable() -> Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext("coderZsq")
            observer.onNext("18")
            observer.onNext("1.88")
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
}

extension ProfileViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
