//
//  IGraphAPI.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift

public enum IGraphAPIError: Error {
    case graphRunTimeError(String)
}

protocol IGraphAPI {
    
    func getMeData(token: String) -> Observable<String>
}
