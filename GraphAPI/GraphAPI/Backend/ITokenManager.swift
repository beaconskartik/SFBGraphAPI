//
//  IToken.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift

public enum TokenError: Error {
    case runTimeError (String)
}

protocol ITokenManager {
    
    func getTokenInteractively() -> Observable<String>
    
    func getTokenSilently() -> Observable<String>
}
