//
//  ConfirmEmailViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class ConfirmEmailViewController: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let emailTxt = UserDefaults.standard.string(forKey: "user_email") {
            emailLbl.text = emailTxt
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    @IBAction func onClickResendBtn(_ sender: Any) {
        let userId = Utility.shared.getUserId()
        let userEmail = Utility.shared.getUserEmail()
        let params = [
            "id": userId
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: RESEND_EMAIL, serviceType: "RESEND EMAIL API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                self.showAlert(title: "Alert", message: responseObj.message ?? "Sorry, something went wrong. Please try again.", controller: self
                    , dismissCompletion: {
                })
            } else {
                self.showAlert(title: "Alert", message: responseObj.message ?? "Sorry, something went wrong. Please try again.", controller: self
                    , dismissCompletion: {
                })
            }
            
        }, fail: { (error) in
            
            
        }, showHUD: true)
    }
    
    
    @IBAction func onClickConfirm(_ sender: Any) {
        print(Utility.shared.isPhoneNumberVerified())
        if !Utility.shared.isPhoneNumberVerified() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyNumberViewController") as! VerifyNumberViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
