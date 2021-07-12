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
        
        let config = Config(clientId: "430023")
        config.sandboxMode = true
        Appboxo.shared.setConfig(config: config)
    }

    @IBAction func openMiniapp(_ sender: Any) {
        let miniapp = Appboxo.shared.getMiniapp(appId: "app34795")
        miniapp.open(viewController: self)
    }
    
}

