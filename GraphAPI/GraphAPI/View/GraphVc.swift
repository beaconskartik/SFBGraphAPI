//
//  GraphVc.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GraphVc {
    
    let graphView: GraphView
    
    private let graphVM: GraphVM
    private let bag = DisposeBag()
    
    init(frame: CGRect, tokenManager: ITokenManager, graphAPI: IGraphAPI) {
        graphView = GraphView(frame: frame)
        graphVM = GraphVM(tokenManager: tokenManager, graphAPI: graphAPI)
        
        setUpListeners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpListeners() {
        graphView.fetchTokenButton.rx.tap
            .debug()
            .map { return true }
            .bind(to: graphVM.fetchToken)
            .disposed(by: bag)
        
        graphView.callGraphAPI.rx.tap
            .debug()
            .map { return true }
            .bind(to: graphVM.callGraphAPI)
            .disposed(by: bag)
        
        graphVM.isTokenFetched
        .bind(to: graphView.callGraphAPI.rx.isEnabled)
        .disposed(by: bag)
        
    }
}




