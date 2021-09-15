//
//  ViewController.swift
//  Paymaya Test
//
//  Created by Azamat Kushmanov on 12/7/21.
//

import UIKit
import AppBoxoSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = Config(clientId: "911311")
        config.sandboxMode = true
        config.permissionsPage = false
        Appboxo.shared.setConfig(config: config)
    }

    @IBAction func openMiniapp(_ sender: Any) {
        let miniapp = Appboxo.shared.getMiniapp(appId: "app34795")
        miniapp.delegate = self
        miniapp.open(viewController: self)
    }
    
}

extension ViewController : MiniappDelegate {
    func onAuth(miniapp: Miniapp) {
        let request = URLRequest(url: URL(string: "https://9w1kyzp49e.execute-api.ap-southeast-1.amazonaws.com/Test/encryptedUserIdentifier")!)
        
        let task =  URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let dict = json as? [String: Any], let body = dict["body"] as? String {
                DispatchQueue.main.sync {
                    miniapp.setAuthCode(authCode: body)
                }
                
            } else {
                DispatchQueue.main.sync {
                    miniapp.setAuthCode(authCode: "")
                }
            }
        })
        
        task.resume()
    }
    
    func didReceivePaymentEvent(miniapp: Miniapp, paymentData: PaymentData) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmPaymentViewController") as! ConfirmPaymentViewController
        vc.paymentData = paymentData
        vc.delegate = self
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
}

extension ViewController : ConfirmPaymentViewControllerDelegate {
    func didPay(vc: ConfirmPaymentViewController, paymentData: PaymentData) {
        let miniapp = Appboxo.shared.getMiniapp(appId: "app34795")
        paymentData.status = "success"
        paymentData.hostappOrderId = "order123456789"
        miniapp.sendPaymentEvent(paymentData: paymentData)
    }
    
    func didCancel(vc: ConfirmPaymentViewController, paymentData: PaymentData) {
        let miniapp = Appboxo.shared.getMiniapp(appId: "app34795")
        paymentData.status = "cancel"
        paymentData.hostappOrderId = "order123456789"
        miniapp.sendPaymentEvent(paymentData: paymentData)
    }
    
    
}
