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
        miniapp.setAuthCode(authCode: "2e3ccbd2-7328-482b-a8f2-1f9860612d00")
    }
}

