//
//  WebServiceManager.swift
//  Phlight
//
//  Created by Atta khan on 08/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SVProgressHUD


class WebServiceManager: NSObject {
    static var serviceCount = 0
    static let sharedInstance = WebServiceManager()
    func setHeader() -> HTTPHeaders {
        let token =  UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            //"Authorization": "\(token!)",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func fetchToken()->String{
        let token =  UserDefaults.standard.string(forKey: "token")
        return token!
    }
    
    func getRequest<T: AnyObject>(params: Dictionary<String, AnyObject>?, serviceName: String, serviceType: String, modelType: T.Type, success: @escaping (_ servicResponse: AnyObject) -> Void, fail: (_ error: NSError) -> Void) where T: Mappable {
        if Utility.shared.isInternetAvailable() {
            let headers: HTTPHeaders
            if serviceType == "Product list PHP"{
                headers = [
                    "Authorization"  :   "u1tx982I"
                ]
            } else {
                headers = setHeader()
            }
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 60
            
            SVProgressHUD.show()
            showNetworkIndicator()
            
            Alamofire.request(serviceName, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
                self.hideNetworkIndicator()
                SVProgressHUD.dismiss()
                switch response.result {
                case .success(let objectData):
                    success(objectData)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            //            UIView.animate(withDuration: 3, animations: {
            //                Utility.InternetConnectioBar(string:Message.nNoInternet)
            //            }, completion: { (action) in
            //                Utility.removeInternetConnectionBar()
            //            })
            SVProgressHUD.dismiss()
            keyWindow?.isUserInteractionEnabled = true
            hideNetworkIndicator()
        }
        
    }
    func post<T: AnyObject>(params: Dictionary<String, AnyObject>, serviceName: String, isLoaderShow : Bool , serviceType: String, modelType: T.Type, success: @escaping ( _ servicResponse: AnyObject) -> Void, fail: @escaping ( _ error: NSError) -> Void, showHUD: Bool)  where T: Mappable {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        showNetworkIndicator()
        
        Alamofire.request(serviceName, method:.post, parameters: params)
            .validate()
            .responseObject { (response: DataResponse<T>) in
                
                self.hideNetworkIndicator()
                
                switch response.result {
                    
                case.success(let objectData):
                    print(response.result)
                    
                    guard (try? objectData) != nil else {
                        return
                    }
                    success(objectData)
                    
                    
                    
                case.failure(let error):
                    print(error.localizedDescription)
                    //                    SVProgressHUD.dismiss()
                    fail(error as NSError)
                }
        }
    }
    
    
    func postRequest<T: AnyObject>(params: NSDictionary, url: URL, serviceType: String, modelType: T.Type, success: @escaping ( _ servicResponse: AnyObject) -> Void, fail: @escaping ( _ error: NSError) -> Void, showHUD: Bool)  where T: Mappable {
        if Utility.shared.isInternetAvailable() {
            if showHUD {
                SVProgressHUD.show()
                keyWindow?.isUserInteractionEnabled = false
                keyWindow?.alpha = 1.0
            } else {
                keyWindow?.isUserInteractionEnabled = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 60
            showNetworkIndicator()
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if serviceType == "PHP Order Form"{
                request.setValue("u1tx982I", forHTTPHeaderField: "Authorization")
            } else {
                request.setValue(fetchToken(), forHTTPHeaderField: "Authorization")
            }
            
            let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            Alamofire.request(request as URLRequestConvertible).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
                keyWindow?.isUserInteractionEnabled = true
                self.hideNetworkIndicator()
                switch response.result {
                case.success(let objectData):
                    print(response.result)
                    
                    SVProgressHUD.dismiss()
                    success(objectData)
                case.failure(let error):
                    print(error.localizedDescription)
                    SVProgressHUD.dismiss()
                    fail(error as NSError)
                }
            })
        } else {
            UIView.animate(withDuration: 3, animations: {
                //Utility.shared.InternetConnectioBar(string: Message.nNoInternet, status: false)
            }, completion: { (action) in
                //Utility.removeInternetConnectionBar()
            })
            keyWindow?.isUserInteractionEnabled = true
        }
        
    }
    
    func postArray<T: AnyObject>(params: Array<Any> , serviceName: URL, serviceType: String, modelType: T.Type, success: @escaping ( _ servicResponse: AnyObject) -> Void, fail: @escaping ( _ error: NSError) -> Void, showHUD: Bool)  where T: Mappable {
        
        if showHUD {
            SVProgressHUD.show()
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        showNetworkIndicator()
        
        var request = URLRequest(url: serviceName)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(fetchToken(), forHTTPHeaderField: "Authorization")
        let values = params
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: values)
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            self.hideNetworkIndicator()
            switch response.result {
            case.success(let objectData):
                SVProgressHUD.dismiss()
                success(objectData)
            case.failure(let error):
                print(error.localizedDescription)
                SVProgressHUD.dismiss()
                fail(error as NSError)
            }
        }
    }
    
    
    
    
    
    func postArrayRequest<T: AnyObject>(params: Array<Any> , serviceName: URL, serviceType: String, modelType: T.Type, success: @escaping ( _ servicResponse: AnyObject) -> Void, fail: @escaping ( _ error: NSError) -> Void, showHUD: Bool)  where T: Mappable {
        
        if showHUD {
            SVProgressHUD.show()
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        showNetworkIndicator()
        
        var request = URLRequest(url: serviceName)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(fetchToken(), forHTTPHeaderField: "Authorization")
        let values = params
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: values)
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            self.hideNetworkIndicator()
            switch response.result {
            case.success(let objectData):
                SVProgressHUD.dismiss()
                success(objectData)
            case.failure(let error):
                print(error.localizedDescription)
                SVProgressHUD.dismiss()
                fail(error as NSError)
            }
        }
    }
    
    func loginRequest<T: AnyObject>(params: Dictionary<String, AnyObject>, serviceName: String, serviceType: String, modelType: T.Type, success: @escaping ( _ servicResponse: AnyObject) -> Void, fail: @escaping ( _ error: NSError) -> Void, showHUD: Bool)  where T: Mappable {
        if Utility.shared.isInternetAvailable() {
            if showHUD {
                SVProgressHUD.show()
            }
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 60
            showNetworkIndicator()
            
            Alamofire.request(serviceName, method:.post, parameters: params, encoding: URLEncoding.default, headers: nil)
                .validate().responseObject { (response: DataResponse<T>) in
                    self.hideNetworkIndicator()
                    switch response.result {
                    case.success(let objectData):
                        print(response.result)
                        
                        SVProgressHUD.dismiss()
                        success(objectData)
                    case.failure(let error):
                        print(error.localizedDescription)
                        SVProgressHUD.dismiss()
                        fail(error as NSError)
                    }
            }
        } else {
            UIView.animate(withDuration: 3, animations: {
                //Utility.InternetConnectioBar(string: Message.nNoInternet, status: false)
            }, completion: { (action) in
                //Utility.removeInternetConnectionBar()
            })
            keyWindow?.isUserInteractionEnabled = true
        }
        
    }
    
    /*
    func multiPartImage<T: AnyObject>(params: Dictionary<String, Any>, serviceName: String,imageParam: String , serviceType: String,profileImage:UIImage? , cover_image_param: String, cover_image: UIImage?,modelType: T.Type, success: @escaping ( _ servicResponse: Any) -> Void, fail: @escaping (_ error: NSError) -> Void) where T: Mappable {
        
        SVProgressHUD.show()
        showNetworkIndicator()
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if profileImage != nil {
                
                if let imageData = UIImage.jpegData(prof)
                
//                'UIImageJPEGRepresentation' has been replaced by instance method 'UIImage.jpegData(compressionQuality:)'
                if let imageData = UIImageJPEGRepresentation(profileImage!, 0.5) {
                    multipartFormData.append(imageData, withName:imageParam, fileName:"", mimeType: "image/png")
                }
            }
            for (key, value) in params {
                let val = value as! String
                multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to: serviceName,
                         encodingCompletion: { encodingResult in
                            
                            self.hideNetworkIndicator()
                            
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    print(response.result.value as Any)
                                    SVProgressHUD.dismiss()
                                    if(response.result.value != nil){
                                        let convertedResponse = Mapper<UserResponse>().map(JSON:response.result.value as! [String : Any])
                                        //                            /let convertedResponse3 = Mapper<UploadedPostObject>().map
                                        success(convertedResponse as AnyObject)
                                    }else{
                                        success("no internet" as AnyObject)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                SVProgressHUD.dismiss()
                                fail(encodingError as NSError)
                            }
                            
        }
        )
    }
    
    */
    
    func showNetworkIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        WebServiceManager.serviceCount += 1
    }
    
    func hideNetworkIndicator() {
        WebServiceManager.serviceCount -= 1
        if WebServiceManager.serviceCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

