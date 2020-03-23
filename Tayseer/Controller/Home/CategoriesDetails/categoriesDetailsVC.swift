//
//  categoriesDetailsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class categoriesDetailsVC: UIViewController {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var subCatTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false)
        
        bannerCollectionView.register(UINib(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        subCatTabelView.register(UINib(nibName: "categoriesDetailsCell", bundle: nil), forCellReuseIdentifier: "cell")
        subCatTabelView.delegate = self
        subCatTabelView.dataSource = self
    }
    
}

extension categoriesDetailsVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
            return cell
        }else {
            return bannerCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
        
    }
}


extension categoriesDetailsVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = subCatTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? categoriesDetailsCell {
            return cell
        }else {
            return categoriesDetailsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return subCatTabelView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = maintenanceVC(nibName: "maintenanceVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
