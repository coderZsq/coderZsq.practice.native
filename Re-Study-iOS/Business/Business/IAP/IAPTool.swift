//
//  IAPTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import StoreKit


class IAPTool: NSObject {
    
    static let shared = IAPTool()
    
    typealias ResultClosure = (_ products: [SKProduct]) -> ()
    typealias StateClosure = (_ state: SKPaymentTransactionState) -> ()
    
    var resultClosure: ResultClosure?
    var stateClosure: StateClosure?
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    class func requiredProducts(result: (_ productIdentifiers: Set<String>) -> ()) {
        let productIdentifiers: Set<String> = ["coderZsq.Business.id1", "coderZsq.Business.id2", "coderZsq.Business.id3"]
        result(productIdentifiers)
    }
    
    func requestAvaliableProducts(productIdentifiers: Set<String>, result: @escaping ResultClosure) {
        resultClosure = result;
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    func purchase(product: SKProduct, result: StateClosure?) {
        stateClosure = result
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension IAPTool: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.invalidProductIdentifiers)
        print(response.products)
        guard let resultClosure = resultClosure else {
            return
        }
        resultClosure(response.products)
    }
}

extension IAPTool: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if let stateClosure = stateClosure {
                stateClosure(transaction.transactionState)
            }
            switch transaction.transactionState {
            case .deferred:
                print("延迟处理")
            case .failed:
                print("失败")
                queue.finishTransaction(transaction)
            case .purchased:
                print("支付成功")
                queue.finishTransaction(transaction)
            case .purchasing:
                print("正在支付")
            case .restored:
                print("恢复购买")
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("移除交易时调用")
        print(transactions)
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("回复购买成功")
    }
}



