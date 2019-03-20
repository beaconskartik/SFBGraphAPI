
//
//  TokenManager.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 19/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import ADALiOS
import RxSwift


class TokenManager: ITokenManager {
 
    // Got from Azure
    private let kClientID = "1a5d4dfb-338b-4e42-8e15-167096c4848f"
    
    // Copied from Sample App
    private let kGraphURI = "https://graph.microsoft.com"
    private let kAuthority = "https://login.microsoftonline.com/common"
    private let kRedirectUri = URL(string: "urn:ietf:wg:oauth:2.0:oob")
    private let defaultSession = URLSession(configuration: .default)
    
    private let adalToken: ReplaySubject<String>
    
    private lazy var authContext : ADAuthenticationContext? = {
        return ADAuthenticationContext(authority: kAuthority, error: nil)
    }()
    
    init() {
        adalToken = ReplaySubject.create(bufferSize: 1)
    }
    
    public func getTokenInteractively() -> Observable<String> {
        return adalToken.amb(getTokenImpl())
    }
    
    func getTokenSilently() -> Observable<String> {
        return adalToken
    }
    
    private func getTokenImpl() -> Observable<String> {
        return Observable.deferred({ [weak self] () -> Observable<String> in
            guard let self = self else { return Observable.error(TokenError.runTimeError("self is nil")) }
            
            guard self.authContext != nil else {
                return Observable.error(TokenError.runTimeError("ADAL context is nil"))
            }
            
            self.authContext?.acquireToken(withResource: self.kGraphURI, clientId: self.kClientID, redirectUri: self.kRedirectUri, completionBlock: { (result) in
                
                guard let result = result else {
                    self.adalToken.onError(TokenError.runTimeError("ADAL context is nil"))
                    return
                }
                
                if (result.status != AD_SUCCEEDED) {
                    self.adalToken.onError(TokenError.runTimeError("ADAL Token Error \(String(describing: result.error.errorDetails))"))
                }
                
                guard let token = result.accessToken else {
                    self.adalToken.onError(TokenError.runTimeError("Result has no token"))
                    return
                }
                
                self.adalToken.onNext(token)
                
            });
            return self.adalToken
        })
    }
}
