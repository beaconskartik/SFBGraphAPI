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
   
    private var graphVc: GraphVc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tokenManager = TokenManager()
        let graphAPI = GraphAPIImpl()
        
        graphVc = GraphVc(frame: UIScreen.main.bounds,
                              tokenManager: tokenManager,
                              graphAPI: graphAPI)
        self.view = graphVc?.graphView
    }
}

