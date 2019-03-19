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
            })
            .flatMap({ [weak self] _ -> Observable<String> in
                guard let self = self else { return Observable.empty()}
                return self.tokenManager.getToken()
            })
            .do(onNext: { [weak self] (token) in
                guard let self = self else { return }
                self.isTokenFetched.accept(true)
                print("Token fetch succesfully \(token)")
            }, onError: { (error) in
                print("Error in fetching token Error: \(error.localizedDescription)")
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "fetchToken"))
            .disposed(by: disposeBag)
        
        callGraphAPI
            .flatMap ({ (Bool) -> Observable<String> in
                // TODO call graph API here
                return Observable.just("")
            })
            .subscribe(LogSubscriberImpl(tag: "kartik", prefix: "callGraphAPI"))
            .disposed(by: disposeBag)
    }
}
