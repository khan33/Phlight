//
//  LoginViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController , GIDSignInUIDelegate, GIDSignInDelegate{

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkBtn: UIImageView!
    @IBOutlet weak var singInbtn: UIButton!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var facebook_icon: UIImageView!
    @IBOutlet weak var gmail_icon: UIImageView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func onClickForgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickGmailBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.delegate = self as! GIDSignInDelegate
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func onClickFbBtn(_ sender: UIButton) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                }
            })
        }
    }
    @IBAction func onClickRememberBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func onClickLoginBtn(_ sender: Any) {
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
        let params = [
            "email": emailTxt,
            "password": passwordTxt,
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: LOGIN, serviceType: "Login API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                UserDefaults.standard.set(responseObj.user_details?.email_verified, forKey: "email_verified")
                UserDefaults.standard.set(responseObj.user_details?.phone_verified, forKey: "phone_verified")
                UserDefaults.standard.set(responseObj.user_details?.email, forKey: "user_email")
                UserDefaults.standard.set(responseObj.user_details?.mobile_number, forKey: "user_phone")
                UserDefaults.standard.set(responseObj.user_details?.id, forKey: "user_id")
                self.launchScreen()
            }
        }, fail: { (error) in
        }, showHUD: true)
    }
    @IBAction func onTapSignupBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func launchScreen() {
        if !Utility.shared.isEmailVerified() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailViewController") as! ConfirmEmailViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else if !Utility.shared.isPhoneNumberVerified() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyNumberViewController") as! VerifyNumberViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("We have a error sign in user == \(error.localizedDescription)")
        } else {
            if let gmailUser = user {
                print(gmailUser.profile)
                print(gmailUser.profile.email)
                print(gmailUser.profile.givenName)
            }
        }
    }
    
}
    

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTF {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        } else if textField == passwordTF {
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        }
        return true
    }
}
