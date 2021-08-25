//
//  ConfirmPaymentViewController.swift
//  PaymayaTest
//
//  Created by Azamat Kushmanov on 25/8/21.
//

import UIKit
import AppBoxoSDK

protocol ConfirmPaymentViewControllerDelegate {
    func didPay(vc: ConfirmPaymentViewController, paymentData: PaymentData)
    func didCancel(vc: ConfirmPaymentViewController, paymentData: PaymentData)
}

class ConfirmPaymentViewController: UIViewController {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var paymentData = PaymentData()
    var delegate : ConfirmPaymentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountLabel.text = "\(paymentData.amount) \(paymentData.currency)"
        orderIdLabel.text = paymentData.miniappOrderId

        payButton.layer.cornerRadius = 20.0
        payButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 20.0
        cancelButton.layer.masksToBounds = true
    }
    @IBAction func pay(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.didPay(vc: self, paymentData: self.paymentData)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.didCancel(vc: self, paymentData: self.paymentData)
        }
    }
}
