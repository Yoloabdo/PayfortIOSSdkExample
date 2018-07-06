//
//  PayfortResponse.swift
//  PayfortiOSSDKExample
//
//  Created by abdelrahman mohamed on 7/6/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
struct PayfortResponse: Codable, CodableInit {
    var sdkToken, responseMessage: String?
}
