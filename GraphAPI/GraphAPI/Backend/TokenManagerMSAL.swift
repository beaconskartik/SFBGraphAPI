//
//  TokenManagerMSAL.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift
import MSAL

class TokenManagerMSAL: ITokenManager {
    
    // Update the below to your client ID you received in the portal. The below is for running the demo only
    let kClientID = "d40357d5-e185-4deb-9ff0-fd6c1f363f4a"
    
    // These settings you don't need to edit unless you wish to attempt deeper scenarios with the app.
    let kGraphURI = "https://graph.microsoft.com/v1.0/me/"
    let kScopes: [String] = ["https://graph.microsoft.com/user.read"]
    let kAuthority = "https://login.microsoftonline.com/common"
    
    var applicationContext : MSALPublicClientApplication?
    
    init() {
        initMSALApplicationContext()
    }
    
    private func initMSALApplicationContext() {
        do {
            guard let authorityURL = URL(string: kAuthority) else {
                print ("Unable to create authority URL")
                return
            }
            
            let authority =  try MSALAuthority(url: authorityURL)
            self.applicationContext = try MSALPublicClientApplication(clientId: kClientID, authority: authority)
        } catch  let error {
            print ("Error while initing context \(error)")
        }
    }
    
    func getTokenInteractively() -> Observable<String> {
        let token = ReplaySubject<String>.create(bufferSize: 1)
        guard let applicationContext = self.applicationContext else {
            return Observable.error(TokenError.runTimeError("MSAL Contex is null"))
        }
        
        applicationContext.acquireToken(forScopes: kScopes) { (result, error) in
            
            if let error = error {
                token.onError(TokenError.runTimeError("Could not acquire token: \(error)"))
                return
            }
            
            guard let result = result else {
                token.onError(TokenError.runTimeError("Could not acquire token: No result returned"))
                return
            }
            
            token.onNext(result.accessToken!)
        
        }
         return token
    }
    
    func getTokenSilently() -> Observable<String> {
        let token = ReplaySubject<String>.create(bufferSize: 1)
        guard let applicationContext = self.applicationContext else {
            return Observable.error(TokenError.runTimeError("MSAL Contex is null"))
        }
        
        applicationContext.acquireTokenSilent(forScopes: kScopes, account: self.currentAccount()) {
            (result, error) in
            
            if let error = error {
                token.onError(TokenError.runTimeError("Could not acquire token: \(error)"))
                return
            }
            
            guard let result = result else {
                token.onError(TokenError.runTimeError("Could not acquire token: No result returned"))
                return
            }
            
            token.onNext(result.accessToken!)
        }
        return token
    }
    
    func currentAccount() -> MSALAccount? {
        
        guard let applicationContext = self.applicationContext else { return nil }
        
        // We retrieve our current account by getting the first account from cache
        // In multi-account applications, account should be retrieved by home account identifier or username instead
        
        do {
            
            let cachedAccounts = try applicationContext.allAccounts()
            
            if !cachedAccounts.isEmpty {
                return cachedAccounts.first
            }
            
        } catch let error as NSError {
            
            print("Didn't find any accounts in cache: \(error)")
        }
        
        return nil
    }
}
