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
       
        let params = [
            "email": "test@gmail.com",
            "id": "123"
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: LOGIN, serviceType: "Login API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                
            }
            
        }, fail: { (error) in
            
            
        }, showHUD: true)
    }
    
    
    @IBAction func onClickConfirm(_ sender: Any) {
        if !Utility.shared.isPhoneNumberVerified() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyNumberViewController") as! VerifyNumberViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
