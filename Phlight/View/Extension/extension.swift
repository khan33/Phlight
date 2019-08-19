//
//  extension.swift
//  Phlight
//
//  Created by Atta Khan on 05/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit
extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showAlert(title: String, message: String, controller: UIViewController?, dismissCompletion:@escaping (AlertViewDismissHandler)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        if controller != nil {
            controller?.present(alert, animated: true, completion: nil)
        }else {
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func showConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action -> Void in
            //Do some other stuff
            
        }))
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        
        present(alertController, animated: true, completion:nil)
    }
    
    
    func showAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        present(alertController, animated: true, completion:nil)
    }

    
}
extension UIColor {
    static var placeholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
    static var placeholderErrorColor: UIColor {
        return UIColor.red
    }
}
