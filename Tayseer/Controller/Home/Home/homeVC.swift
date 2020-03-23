//
//  homeVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categouryCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpNavColore(false)
        
        bannerCollectionView.register(UINib(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        categouryCollectionView.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        categouryCollectionView.delegate = self
        categouryCollectionView.dataSource = self
        
    }
    
}

extension homeVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == bannerCollectionView {
            return 1
        }else {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return 10
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
                return cell
            }else {
                return bannerCell()
            }
        }else {
            if let cell = categouryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? categoryCell {
                return cell
            }else {
                return categoryCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == bannerCollectionView {
            return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
        }else {
            
            let leftAndRightPadding: CGFloat = 18.0
            let numberOfItemPerRow: CGFloat = 3.0
            //let hightAdjustment: CGFloat = 30.0
            let width = (categouryCollectionView.frame.width-leftAndRightPadding) / numberOfItemPerRow
            return CGSize.init(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView {
            print("xxx")
        }else {
            let vc = categoriesDetailsVC(nibName: "categoriesDetailsVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
}
