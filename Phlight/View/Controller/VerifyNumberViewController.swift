//
//  VerifyNumberViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class VerifyNumberViewController: UIViewController {

    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    @IBOutlet weak var mobileNbLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let phoneTxt = UserDefaults.standard.string(forKey: "user_phone") {
            mobileNbLbl.text = "Enter OTP sent to \(phoneTxt)"
        }
        tf1.becomeFirstResponder()
    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    
    @IBAction func onClickResendCode(_ sender: Any) {
        let params = [
            "email": "test@gmail.com",
            "id": "123"
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: LOGIN, serviceType: "Login API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }, fail: { (error) in
            
            
        }, showHUD: true)
        
    }
    
    @IBAction func onClickVerifyNumber(_ sender: Any) {
        
        let code = "\(tf1.text ?? "")\(tf2.text ?? "")\(tf3.text ?? "")\(tf4.text ?? "")"
        let userId = Utility.shared.getUserId()
        
        let params = [
            "code": code,
            "id": userId
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: VERIFY_OTP_CODE, serviceType: "Verify OTP Code", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            print(responseObj.message)
            if responseObj.status == true {
                UserDefaults.standard.set(true, forKey: "phone_verified")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            
            
        }, fail: { (error) in
            
            
        }, showHUD: true)
    }
}
extension VerifyNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if ((textField.text?.count)! < 1 ) && (string.count > 0) {
            if textField == tf1 {
                tf2.becomeFirstResponder()
            }
            
            if textField == tf2 {
                tf3.becomeFirstResponder()
            }
            
            if textField == tf3 {
                tf4.becomeFirstResponder()
            }
            
            if textField == tf4 {
                tf4.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if textField == tf2 {
                tf1.becomeFirstResponder()
            }
            if textField == tf3 {
                tf2.becomeFirstResponder()
            }
            if textField == tf4 {
                tf3.becomeFirstResponder()
            }
            if textField == tf1 {
                tf1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
        
        
        
        
        
        
//        let text = textField.text
//
//        if (text?.utf16.count)! < 1 && (string.count > 0) {
//            switch textField {
//            case tf1:
//                tf2.becomeFirstResponder()
//            case tf2:
//                tf3.becomeFirstResponder()
//            case tf3:
//                tf4.becomeFirstResponder()
//            case tf4:
//                tf4.resignFirstResponder()
//            default:
//                break
//            }
//            textField.text = string
//            return false
//        } else if (text?.utf16.count)! >= 1 && (string.count > 0) {
//            switch textField {
//            case tf2:
//                tf1.becomeFirstResponder()
//            case tf3:
//                tf2.becomeFirstResponder()
//            case tf4:
//                tf3.becomeFirstResponder()
//            case tf1:
//                tf1.resignFirstResponder()
//            default:
//                break
//            }
//            textField.text = ""
//            return false
//        } else if (text?.utf16.count)! >= 1 {
//            textField.text = string
//            return false
//        }
//        return true
    }
}
