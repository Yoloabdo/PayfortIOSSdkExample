//
//  PayfortRequest.swift
//  PayfortiOSSDKExample
//
//  Created by abdelrahman mohamed on 7/6/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

enum PayFortCredintials {
    case development(udid: String)
    case production(udid: String)
    
    var merchantId: String {
        switch self {
        case .development:
            return "dfadf23"
        default:
            return "dsafq34r"
        }
    }
    
    var accessCode: String {
        switch self {
        case .development:
            return "wO5asdfasdzw57vUbYE1"
        default:
            return "adsfadsfAMIP3qewH9hrtm"
        }
    }
    
    
    var shaRequest: String {
        switch self {
        case .development:
            return "adsfajytjijht"
        default:
            return "dadsf3*4$T#^$@&g"
        }
    }
    
    var currency: String { return "SAR" }
    
    
    func signature(uid: String) -> String {
        return Encryption.sha256Hex(string: self.preSignature(uid)) ?? "Can't happen."
    }
    
    private func preSignature(_ uid: String) -> String {
        return self.shaRequest + "access_code=\(self.accessCode)" + "device_id=\(uid)" + "language=enmerchant_identifier=\(self.merchantId)" + "service_command=SDK_TOKEN\(self.shaRequest)"
    }
    
    
    
    func parameters(with udid: String) -> [String: Any] {
        return ["access_code": accessCode,
                "device_id": udid,
                "language": "en",
                "merchant_identifier": merchantId,
                "service_command": "SDK_TOKEN",
                "signature": signature(uid: udid)
        ]
    }
}




extension PayFortCredintials: URLRequestBuilder {
    var path: String {
        return "FortAPI/paymentApi"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var mainURL: URL {
        switch self {
        case .development:
            return URL(string: "https://sbpaymentservices.payfort.com")!
        default:
            return URL(string: "https://paymentservices.payfort.com")!
        }
    }
   
    
    var parameters: Parameters? {
        switch self {
        case .development(let udid):
            return parameters(with: udid)
        case .production(let udid):
            return parameters(with: udid)
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-type"] = "application/x-www-form-urlencoded; charset=utf-8"
        headers["Content-type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}
