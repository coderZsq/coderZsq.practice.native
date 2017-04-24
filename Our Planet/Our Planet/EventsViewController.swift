//
//  EventsViewController.swift
//  Our Planet
//
//  Created by 双泉 朱 on 17/4/21.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import RxSwift

class EventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var daysLabel: UILabel!

    let events = Variable<[EOEvent]>([])
    let disposeBag = DisposeBag()
    
    let days = Variable<Int>(360)
    let filteredEvent = Variable<[EOEvent]>([])
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        events.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        
        Observable.combineLatest(days.asObservable(), events.asObservable()) { (days, events) -> [EOEvent] in
            let maxInterval = TimeInterval(days * 24 * 3600)
            return events.filter { event in
                if let date = event.closeDate {
                    return abs(date.timeIntervalSinceNow) < maxInterval
                }
                return true
            }
        }.bind(to: filteredEvent).addDisposableTo(disposeBag)
    
        filteredEvent.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)

        days.asObservable().subscribe(onNext: { [weak self] days in
            self?.daysLabel.text = "Last \(days) days"
        }).addDisposableTo(disposeBag)
    }

}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvent.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let event = filteredEvent.value[indexPath.row]
        cell.configure(event: event)
        return cell
    }
}

extension EventsViewController {

    @IBAction func sliderAction(_ sender: AnyObject) {
        days.value = Int(slider.value)
    }
}
