//
//  LogSubscriberImpl.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift

public class LogSubscriberImpl<E>: SubscriberImpl<E>{
    
    private let logOnCompleted: Bool
    private let tag: String
    private let loggerPrefix: String
    
    public init(tag: String, prefix: String, logOnCompleted: Bool = true) {
        self.tag = tag
        self.loggerPrefix = prefix
        self.logOnCompleted = logOnCompleted
    }
    
    override func onCompleted() {
        if(logOnCompleted) {
            print("\(tag) , \(loggerPrefix) onCompletedImpl")
        }
    }
    
    override func onError(_ error: Error) {
        print("\(tag) , \(loggerPrefix) onErrorImpl: \(error.localizedDescription)")
    }
    
    override func onNext(_ element: E) {
         print("\(tag) , \(loggerPrefix) onNext: ")
    }
}
