//
//  ForgotPasswordViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickRestPassword(_ sender: Any) {
        
        guard let emailTxt = emailTF.text, !emailTxt.isEmpty else {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(emailView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your email")
            return
        }
        let params = [
            "email": emailTxt
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: FORGOT_PASSWORD, serviceType: "FORGOT PASSWORD", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                self.showAlert(title: "Alert", message: responseObj.message ?? "Sorry, something went wrong. Please try again.", controller: self
                    , dismissCompletion: {
                        self.navigationController?.popViewController(animated: true)
                })
            } else {
                self.showAlert(title: "Alert", message: responseObj.message ?? "Sorry, something went wrong. Please try again.", controller: self
                    , dismissCompletion: {
                })
            }
            
            
            
        }, fail: { (error) in
            
            
        }, showHUD: true)
        
        
    }
    @IBAction func onClickSignUpBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
