//
//  SignUpViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var mobileNbView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var c_passwordView: UIView!
    @IBOutlet weak var invitationCodeView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileNbTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var c_passwordTF: UITextField!
    @IBOutlet weak var invitationCodeTF: UITextField!
    @IBOutlet weak var userImgView: UIImageView!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        mobileNbTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        c_passwordTF.delegate = self
        invitationCodeTF.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let cgFloat: CGFloat = userImgView.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        Utility.shared.setViewCornerRadius(self.userImgView, radius: CGFloat(someFloat))
    }
    
    @IBAction func onClickProfileImg(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func onClickAcceptBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func tapOnRegisterBtn(_ sender: Any) {
        guard let nameTxt  = nameTF.text, !nameTxt.isEmpty else {
            nameTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(userNameView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your name.")
            return
        }
        guard let mobileNbTxt = mobileNbTF.text, !mobileNbTxt.isEmpty else {
            mobileNbTF.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(mobileNbView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your mobile number.")
            return
        }
        guard let emailTxt = emailTF.text, !emailTxt.isEmpty else {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(emailView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your email")
            return
        }
        guard let passwordTxt = passwordTF.text, !passwordTxt.isEmpty else {
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(passwordView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your password")
            return
        }
        guard let c_passwordTxt = emailTF.text, !c_passwordTxt.isEmpty else {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(c_passwordView)
            ToastView.shared.long(self.view, txt_msg: "Please enter your Confirm Password")
            return
        }
        let invitionalCode = invitationCodeTF.text ?? ""
        
        
        let params = [
            "email": emailTxt,
            "password": passwordTxt,
            "name": nameTxt,
            "c_password": c_passwordTxt
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: REGISTER, serviceType: "REGISTER API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                print(responseObj.message)
                
                
            } else {
                print(responseObj.message)
            }
            
        }, fail: { (error) in
            
            
        }, showHUD: true)
        
        
        
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTF {
            nameTF.attributedPlaceholder = NSAttributedString(string: "Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == mobileNbTF {
            mobileNbTF.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == emailTF {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == passwordTF {
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == c_passwordTF {
            c_passwordTF.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == invitationCodeTF {
            invitationCodeTF.attributedPlaceholder = NSAttributedString(string: "Invitation Code",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        }
        return true
    }
}
extension SignUpViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.userImgView.contentMode = .scaleAspectFill
        self.userImgView.image = image
    }
    
}
