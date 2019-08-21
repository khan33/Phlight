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
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var editPhotoBtn: UIButton!
    
    
    var imagePicker: ImagePicker!
    var prfileImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let cgFloat: CGFloat = imageView.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        Utility.shared.setViewCornerRadius(self.imageView, radius: CGFloat(someFloat))
    }
    override func viewWillAppear(_ animated: Bool) {
        let profileImgURL: String? = UserDefaults.standard.string(forKey: "profile_img")
        if let profileImg = profileImgURL {
            if let url: URL = URL(string: profileImg) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "upload_photo"))
            }
        }
    }
    
    @IBAction func onClickPhotoBtn(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func onClickCancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickDoneBtn(_ sender: Any) {
        
    }
    
}
extension UpdateProfileVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        prfileImg = image
    }
    
}
