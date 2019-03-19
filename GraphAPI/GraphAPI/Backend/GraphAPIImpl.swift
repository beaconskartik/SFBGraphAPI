//
//  GraphAPI.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import RxSwift

class GraphAPIImpl: IGraphAPI {
    
    let kGraphURI = "https://graph.microsoft.com"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    
    func getMeData(token: String) -> Observable<String> {
        let result = ReplaySubject<String>.create(bufferSize: 1)
        
        let url = URL(string: kGraphURI + "/v1.0/me/")
        var request = URLRequest(url: url!)
        // copied from Sample app
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            
            if let error = error {
                result.onError(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                result.onError(IGraphAPIError.graphRunTimeError("Couldn't get graph result"))
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                guard let resultData = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                    print("Couldn't deserialize result JSON")
                    return
                }
                
                result.onNext(resultData as? String ?? "Couldn't cast it into string")
            }
            
        }
        
        self.dataTask?.resume()
        return result
    }
    
    
}
