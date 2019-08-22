//
//  UpdateProfileVC.swift
//  Phlight
//
//  Created by Atta khan on 08/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit
import SDWebImage

class UpdateProfileVC: UIViewController {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var editPhotoBtn: UIButton!
    
    
    var imagePicker: ImagePicker!
    var prfileImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let cgFloat: CGFloat = imageView.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        Utility.shared.setViewCornerRadius(self.imageView, radius: CGFloat(someFloat))
        
        
        populateValue()
    }
    override func viewWillAppear(_ animated: Bool) {
        let profileImgURL: String? = UserDefaults.standard.string(forKey: "profile_img")
        if let profileImg = profileImgURL {
            if let url: URL = URL(string: profileImg) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "upload_photo"))
            }
        }
        usernameLbl.text = UserDefaults.standard.string(forKey: "user_name")
    }
    func populateValue() {
        nameTF.text = UserDefaults.standard.string(forKey: "user_name")
        emailTF.text = UserDefaults.standard.string(forKey: "user_email")
        mobileTF.text = UserDefaults.standard.string(forKey: "user_phone")
    }
    
    
    
    
    @IBAction func onClickPhotoBtn(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func onClickCancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickDoneBtn(_ sender: Any) {
        guard let nameTxt  = nameTF.text, !nameTxt.isEmpty else {
            nameTF.attributedPlaceholder = NSAttributedString(string: "Name",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(userNameView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your name.")
            return
        }
        guard let mobileNbTxt = mobileTF.text, !mobileNbTxt.isEmpty else {
            mobileTF.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(mobileNumberView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your mobile number.")
            return
        }
        guard let emailTxt = emailTF.text, !emailTxt.isEmpty else {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderErrorColor])
            Utility.shared.shakeView(emailView)
            ToastView.shared.short(self.view, txt_msg: "Please enter your email")
            return
        }
        let userId = Utility.shared.getUserId()
        let params = [
            "id": userId,
            "name": nameTxt,
            "email": emailTxt,
            "mobile_no": mobileNbTxt,
            "latitude": "",
            "longitude": "",
            ] as [String: Any]
        
        WebServiceManager.sharedInstance.loginRequest(params: params as Dictionary<String, AnyObject>, serviceName: UPDATE_PROFILE, serviceType: "UPDATE PROFILE API", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                if self.prfileImg != nil {
                    self.uploadImage(userId)
                }
                
                UserDefaults.standard.set(responseObj.data?.email_verified, forKey: "email_verified")
                UserDefaults.standard.set(responseObj.data?.phone_verified, forKey: "phone_verified")
                UserDefaults.standard.set(responseObj.data?.email, forKey: "user_email")
                UserDefaults.standard.set(responseObj.data?.mobile_number, forKey: "user_phone")
                
                
                UserDefaults.standard.set(responseObj.data?.name, forKey: "user_name")
                self.showAlert(title: "Alert", message: "You have updated successfully..", controller: self
                    , dismissCompletion: {
                        if !Utility.shared.isEmailVerified() {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailViewController") as! ConfirmEmailViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else if !Utility.shared.isPhoneNumberVerified() {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyNumberViewController") as! VerifyNumberViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            
                        }
                })
                
            } else {
                self.showAlert(title: "Alert", message: responseObj.message ?? "Sorry, something went wrong. Please try again.", controller: self
                    , dismissCompletion: {
                })
            }
            
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    func uploadImage(_ userID: Int) {
        let  params: NSDictionary = [
            "id": userID
        ]
        WebServiceManager.sharedInstance.multiPartImage(params: params as! Dictionary<String, Any>, serviceName: UPLOAD_IMG, imageParam: "image", serviceType: "upload Image", profileImage: prfileImg, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status ?? false {
                UserDefaults.standard.set(responseObj.user_details?.user_image, forKey: "profile_img")
                self.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            //
            
        }
        
        
    }
    
}
extension UpdateProfileVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        prfileImg = image
    }
    
}
