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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
}
extension SupportedAreasVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreViewCell", for: indexPath) as! StoreViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 55.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreLocationVC") as! StoreLocationVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
