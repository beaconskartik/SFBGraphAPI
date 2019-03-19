//
//  SubscriberImpl.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation

import RxSwift

public class SubscriberImpl<E>: ObserverType{
    
    public func on(_ event: Event<E>) {
        
        switch event {
        /// Next element is produced.
        case .next(let element):
            onNext(element)
            
        /// Sequence terminated with an error.
        case .error(let error):
            onError(error)
        /// Sequence completed successfully.
        case .completed:
            onCompleted()
        }
    }
    
    func onCompleted() {
    }
    
    func onError(_ error: Error) {
    }
    
    func onNext(_ element: E) {
    }
}
