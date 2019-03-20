//
//  GraphVM.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class GraphVM {
    
    private(set) var fetchToken = PublishRelay<Bool>()
    private(set) var callGraphAPI = PublishRelay<Bool>()
    
    private(set) var isTokenFetched = PublishRelay<Bool>()
    
    private let disposeBag = DisposeBag()
    private let tokenManager: ITokenManager
    private let graphAPI: IGraphAPI
    private var token: String?
    
    init(tokenManager: ITokenManager, graphAPI: IGraphAPI) {
        self.tokenManager = tokenManager
        self.graphAPI = graphAPI
        setupListener()
    }
    
    private func setupListener() {
        
        fetchToken
            .do(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.isTokenFetched.accept(false)
                self.fetchADALToken()
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "fetchToken"))
            .disposed(by: disposeBag)
        
        callGraphAPI
            .do(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.callGraphAPIWithToken()
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "callGraphAPI"))
            .disposed(by: disposeBag)
    }
    
    private func fetchADALToken() {
        tokenManager
            .getTokenInteractively()
            .do(onNext: { [weak self] (token) in
                guard let self = self else { return }
                self.isTokenFetched.accept(true)
                self.token = token
                print("Token fetch succesfully \(token)")
                }, onError: { (error) in
                    print("Error in fetching token Error: \(error.localizedDescription)")
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "fetchADALToken"))
            .disposed(by: disposeBag)
    }
    
    // TODO ideally it should automatically call the fetchADALToken API then trigger graph search
    private func callGraphAPIWithToken() {
        graphAPI
            .getMeData(token: token!)
            .do(onNext: { (data) in
                print ("Information: \(data)")
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "callGraphAPIWithToken"))
            .disposed(by: disposeBag)
    }
}
