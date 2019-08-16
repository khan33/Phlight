//
//  VerifyNumberViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class VerifyNumberViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    
    
}
