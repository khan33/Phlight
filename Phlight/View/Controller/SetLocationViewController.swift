//
//  SetLocationViewController.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class SetLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickCurrentLocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailViewController") as! ConfirmEmailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickManualBtn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryAddressVC") as! DeliveryAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickSupportedAreas(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SupportedAreasVC") as! SupportedAreasVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
