//
//  DeliveryAddressVC.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class DeliveryAddressVC: UIViewController {

    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateValue()
    }
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickSaveBtn(_ sender: Any) {
        guard let addressTxt  = addressTF.text, !addressTxt.isEmpty else {
            addressTF.attributedPlaceholder = NSAttributedString(string: "Address",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            //Utility.shared.shakeView(userNameView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your Address.")
            return
        }
        guard let cityTxt = cityTF.text, !cityTxt.isEmpty else {
            cityTF.attributedPlaceholder = NSAttributedString(string: "City",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            //Utility.shared.shakeView(mobileNbView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your City.")
            return
        }
        guard let zipTxt = zipTF.text, !zipTxt.isEmpty else {
            zipTF.attributedPlaceholder = NSAttributedString(string: "zip",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            //Utility.shared.shakeView(emailView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your Zip")
            return
        }
        guard let stateTxt = stateTF.text, !stateTxt.isEmpty else {
            stateTF.attributedPlaceholder = NSAttributedString(string: "State",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
//            Utility.shared.shakeView(passwordView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your state")
            return
        }
        
        guard let countryTxt = countryTF.text, !countryTxt.isEmpty else {
            countryTF.attributedPlaceholder = NSAttributedString(string: "Country",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            //            Utility.shared.shakeView(passwordView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your country")
            return
        }
        
        
        UserDefaults.standard.set(addressTxt, forKey: "delivery_address")
        UserDefaults.standard.set(zipTxt, forKey: "delivery_zip")
        UserDefaults.standard.set(cityTxt, forKey: "delivery_city")
        UserDefaults.standard.set(stateTxt, forKey: "delivery_state")
        UserDefaults.standard.set(countryTxt, forKey: "delivery_country")
        
        populateValue()
        self.showAlert(title: "Alert", message: "You have added successfully.", controller: self
            , dismissCompletion: {
                
        })
    }
    func populateValue() {
        addressTF.text = UserDefaults.standard.string(forKey: "delivery_address")
        zipTF.text = UserDefaults.standard.string(forKey: "delivery_zip")
        cityTF.text = UserDefaults.standard.string(forKey: "delivery_city")
        stateTF.text = UserDefaults.standard.string(forKey: "delivery_state")
        countryTF.text = UserDefaults.standard.string(forKey: "delivery_country")
    }
    
}
