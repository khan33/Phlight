//
//  ViewController.swift
//  Phlight
//
//  Created by Atta Khan on 04/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pages: [Page]  = {
        let firstPage = Page(title: "Your delivery, on demand", message: "Whether you're headed to work, the airport, or out of the twon. Radio connects with a reliable ride in a minute.\n One tap and a car comes directly to you", imageName: "onboarding", isHidden: true)
        let secondPage = Page(title: "Anywhere, Anytime", message: "You can get your delivery at your only using Phlight", imageName: "building", isHidden: true)
        let thirdPage = Page(title: "Track Your Delivery", message: "Know your driver in advance and be able to view current location in real time on  the map", imageName: "location",isHidden: false)
        return [firstPage, secondPage, thirdPage]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PageCollectionViewCell.nib, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
        //navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / view.frame.width
        
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as! PageCollectionViewCell
        cell.pageController.numberOfPages = pages.count
        cell.pageController.currentPage = indexPath.item
        let page = pages[indexPath.item]
        cell.page = page
        cell.welcomeBtn.addTarget(self, action: #selector(onClickWelcomeBtn), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    @objc func onClickWelcomeBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
