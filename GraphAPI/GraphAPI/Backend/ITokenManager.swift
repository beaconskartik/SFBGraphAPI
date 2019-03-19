//
//  IToken.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol ITokenManager {
    
    func getToken() -> Observable<String>
    
    // implement other API here like getToken Scerectly here
}
