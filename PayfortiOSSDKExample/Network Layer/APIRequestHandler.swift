//
//  APIManager.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 1/29/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire



/// Response completion handler beautified.
typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?


/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamoResponse {}

extension APIRequestHandler where Self: URLRequestBuilder {

    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>) {
        request(self).validate().responseData {(response) in
            self.handleResponse(response, completion: completion)
        }
    }
}

