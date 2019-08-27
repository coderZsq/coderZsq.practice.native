//
//  ViewController.swift
//  27-响应式编程
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    var hidden: Binder<Bool> {
        Binder<Bool>(base) { view, value in
            view.isHidden = value
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!

    lazy var bag = DisposeBag()
    lazy var observable = Observable.just(1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - RxSwift的核心角色
        /*
         Observable: 负责发送事件(Event)
         Observer: 负责订阅Observable, 监听Observable发送的事件(Event)
         
         Event有3种
         next: 携带具体数据
         error: 携带错误信息, 表明Observable终止, 不会再发出事件
         completed: 表明Observable终止, 不会再发出事件
         */
        
        do {
            enum Event<Element> {
                case next(Element)
                case error(Swift.Error)
                case completed
            }
        }
        
        // MARK: - 创建, 订阅Observable1
        
        do {
            var observable = Observable<Int>.create { observer in
                observer.onNext(1)
                observer.onCompleted()
                return Disposables.create()
            }
            // 等价于
            observable = Observable.just(1)
            observable = Observable.of(1)
            observable = Observable.from([1])
            
            observable.subscribe { event in
                print(event)
            }.dispose()
        }
        
        do {
            var observable = Observable<Int>.create { observer in
                observer.onNext(1)
                observer.onNext(2)
                observer.onNext(3)
                observer.onCompleted()
                return Disposables.create()
            }
            // 等价于
            observable = Observable.of(1, 2, 3)
            observable = Observable.from([1, 2, 3])
            
            observable.subscribe(onNext: {
                print("next", $0)
            }, onError: {
                print("error", $0)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("dispose")
            }).dispose()
        }
        
        // MARK: - 创建, 订阅Observable2
        
        do {
            let observable = Observable<Int>.timer(.seconds(3),
                                                   period: .seconds(1),
                                                   scheduler: MainScheduler.instance)
            observable.map { "数值是\($0)" }
                .bind(to: label.rx.text)
                .disposed(by: bag)
        }
        
        // MARK: - 创建Observer
        
        do {
            let observer = AnyObserver<Int>.init { event in
                switch event {
                case .next(let data):
                    print(data)
                case .completed:
                    print("completed")
                case .error(let error):
                    print("error", error)
                }
            }
            Observable.just(1).subscribe(observer).dispose()
        }
        
        do {
            let binder = Binder<String>(label) { label, text in
                label.text = text
            }
            Observable.just(1).map { "数值是\($0)" }.subscribe(binder).dispose()
            Observable.just(1).map { "数值是\($0)" }.bind(to: binder).dispose()
        }
        
        // MARK: - 扩展Binder属性
        
        do {
            let observable = Observable<Int>.interval(.seconds(1),
                                                      scheduler: MainScheduler.instance)
            observable.map { $0 % 2 == 0 }.bind(to: button.rx.hidden).disposed(by: bag)
        }
        
        // MARK: - RxSwift的状态监听1
        
        do {
            button.rx.tap.subscribe(onNext: {
                print("按钮被点击了1")
            }).disposed(by: bag)
        }
        
        do {
            struct Person {
                var name: String
                var age: Int
            }
            
            let data = Observable.just([
                Person(name: "Jack", age: 10),
                Person(name: "Rose", age: 20)
            ])
            data.bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, person, cell in
                cell.textLabel?.text = person.name
                cell.detailTextLabel?.text = "\(person.age)"
            }.disposed(by: bag)
            
            tableView.rx.modelSelected(Person.self).subscribe(onNext: { person in
                print("点击了", person.name)
            }).disposed(by: bag)
        }
        
        // MARK: - RxSwift的状态监听2
        
        do {
            class Dog: NSObject {
                @objc dynamic var name: String?
            }
            let dog = Dog()
            dog.rx.observe(String.self, "name").subscribe(onNext: { name in
                print("name is", name ?? "nil")
            }).disposed(by: bag)
            dog.name = "larry"
            dog.name = "wangwang"
        }
        
        do {
            NotificationCenter.default.rx
                .notification(UIApplication.didEnterBackgroundNotification)
                .subscribe(onNext: { notification in
                    print("APP进入后台", notification)
                }).disposed(by: bag)
        }
        
        // MARK: - 既是Observable, 又是Observer
        
        do {
            Observable.just(0.8).bind(to: slider.rx.value).dispose()
        }
        
        do {
            slider.rx.value.map {
                "当前数值是: \($0)"
            }.bind(to: textField.rx.text).disposed(by: bag)
        }
        
        do {
            textField.rx.text
                .subscribe(onNext: { text in
                print("text is", text ?? "nil")
            }).disposed(by:  bag)
        }
        
        // MARK: - Disposable
        /*
         每当Observable被订阅时, 都会返回一个Disposable实例, 当调用Disoisable的dispose, 就相当于取消订阅
         在不需要再接收事件时, 建议取消订阅, 释放资源. 有3种常见方式取消订阅
         */
        
        do {
            // 立即取消订阅 (一次性订阅)
            observable.subscribe { event in
                print(event)
            }.dispose()
        }
        
        do {
            // 当bag销毁 (deinit) 时, 会自动调用 Disposable 实例的 dispose
            observable.subscribe { event in
                print(event)
            }.disposed(by: bag)
        }
        
        do {
            // self 销毁时 (deinit) 时, 会自动调用 Disposable 实例的 dispose
            let _ = observable.takeUntil(self.rx.deallocated).subscribe { event in
                print(event)
            }
        }
    }
}

