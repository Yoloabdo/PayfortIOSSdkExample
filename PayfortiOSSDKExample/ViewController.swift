//
//  ViewController.swift
//  PayfortiOSSDKExample
//
//  Created by abdelrahman mohamed on 7/6/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPaymentController(_ sender: Any) {
        guard let payFortController = PayFortController(enviroment: KPayFortEnviromentSandBox) else { return }
        
        PayFortCredintials.development(udid: payFortController.getUDID()!).send(PayfortResponse.self) { (results) in
            switch results {
            case .success(let key):
                if let token = key.sdkToken {
                    self.ShowPayfort(controller: payFortController, with: CurrentOrder(orderTotalSar: 90, id: 2341), token: token)
                }else {
//                    self.showError(sub: key.responseMessage)
                }
            case .failure(let error):
//                self.showError(sub: error?.localizedDescription)
                print(error)
            }
        }
    }
    
    func ShowPayfort(controller: PayFortController, with order: CurrentOrder, token sdkToken: String) {
//        let user = UserManager.shared.currentUserInfo
        let request = NSMutableDictionary()
        let updatedAmount: Float = Float(order.orderTotalSar * 100)
        
        request.setValue(updatedAmount, forKey: "amount")
        request.setValue("PURCHASE", forKey: "command")//PURCHASE - AUTHORIZATION
        request.setValue("SAR", forKey: "currency")
        request.setValue("test@gmail.com" , forKey: "customer_email")
        request.setValue("ar", forKey: "language")
        request.setValue(order.id, forKey: "merchant_reference")
        request.setValue(sdkToken, forKey: "sdk_token")
        
        controller.callPayFort(withRequest: request,
                               currentViewController: self,
                               success: { (_, response) in
//                                self.sendPayfortToServer(response)
                                // handle payfort response after success aka send it to your server
                                print("Success")
                                
        }, canceled: { (request, response) in
            //                self.showError(sub: response[""])
            print("Canceled")
        }, faild: { (requst, response, message) in
//            self.showError(sub: message)
            print("Failed")
        })
    }
    
}


struct CurrentOrder {
    
    var orderTotalSar: Double
    var id: Int
    
}
