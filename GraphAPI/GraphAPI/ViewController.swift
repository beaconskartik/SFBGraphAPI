//
//  ViewController.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 19/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tokenManager = TokenManager()
        tokenManager.getToken()
            .do(onNext: { (token) in
                 print ("Access Token to be used in Graph API \(token)")
            }, onError: { (error) in
                print ("Error while fetching token \(error.localizedDescription)")
            })
            .subscribe()
            .disposed(by: bag)
    }
}

