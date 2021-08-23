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
}

