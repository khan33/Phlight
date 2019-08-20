//
//  SupportedAreasVC.swift
//  Phlight
//
//  Created by Atta khan on 09/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class SupportedAreasVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBarTF: UISearchBar!
    
    var storeData: [StoreModel]?
    var searchStore: [StoreModel]?
    var searching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarTF.barTintColor = UIColor.white
        searchBarTF.backgroundImage = UIImage()
        searchBarTF.delegate = self
        getAllStore()
    }
    func getAllStore() {
        let url = ALL_STROE
        WebServiceManager.sharedInstance.getRequest(params: nil, serviceName: url, serviceType: "Get Store", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                self.storeData = responseObj.store_data
                self.searchStore = self.storeData
                self.setUpTableView()
            }
            
        }) { (error) in
            print(error)
        }
    }
    private func setUpTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
    }
}
extension SupportedAreasVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchStore?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreViewCell", for: indexPath) as! StoreViewCell
        cell.storeName.text = searchStore?[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 55.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreLocationVC") as! StoreLocationVC
        vc.store_data = searchStore?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SupportedAreasVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchStore = storeData
            tableview.reloadData()
            return
        }
        searchStore = storeData?.filter({ store -> Bool in
            return store.name?.lowercased().contains(searchText.lowercased()) ?? false
            
            
        })
        tableview.reloadData()
    }
}
