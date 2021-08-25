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
        miniapp.setAuthCode(authCode: "x+aipn0ODYv4+PZnqiogWVR1rGA4YQFlwmFTT6GV2Rza9LelWQjFUXy5k1SMgmZolDGd5+zh0IJc3vokMBldC74qkKUUoPI1z4K381kbBOW0az+xfs/UCZFkQZbSq5iEn7fofVHxCaSh66JZjZrjzuc9dSkW3IaUBjW/krZpV2Qr58emYQrUqBHb2N7YM01msXJPaasLbEaS3I3FCZ3cfcoSTZxzWQwQ3Chv2jpcaDEJ/7nHekInkwjgAa5x03Eu9bhlzv3uqbQd7xMOFEIRCGOubYkXn2udueeQuzG+tYv+CuShiI6KRbpXwtWmQidgsO1LhAP4KK6IZg4j3OHoZg==")
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
