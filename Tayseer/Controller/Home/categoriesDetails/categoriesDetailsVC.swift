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
    @IBOutlet weak var bageControl: UIPageControl!
    
    var singleItem: sectionsData?
    var slider = [sliderData]()
    var timer : Timer?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, singleItem?.title ?? "")
        
        bannerCollectionView.register(UINib(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        subCatTabelView.rowHeight = UITableView.automaticDimension
        subCatTabelView.estimatedRowHeight = UITableView.automaticDimension
        subCatTabelView.register(UINib(nibName: "categoriesDetailsCell", bundle: nil), forCellReuseIdentifier: "cell")
        subCatTabelView.delegate = self
        subCatTabelView.dataSource = self
        
        sliderHandelRefresh()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }
    
    func sliderHandelRefresh(){
        categoryApi.sliderApi(section_id: singleItem?.id ?? 0){ (error,success,slider) in
            if let slider = slider{
                self.slider = slider.data ?? []
                print(slider)
                self.bageControl.isHidden = false
                self.bageControl.numberOfPages = self.slider.count
                self.bageControl.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
}

extension categoriesDetailsVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
            cell.configureCell(images: slider[indexPath.row])
            return cell
        }else {
            return bannerCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView{
            currentIndex = Int(scrollView.contentOffset.x / bannerCollectionView.frame.size.width)
            bageControl.currentPage = currentIndex
        }
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
            if indexPath.row == 0 {
                if singleItem?.haveProduct == "0" {
                    cell.isHidden = true
                }else if singleItem?.haveProduct == "1" {
                    cell.catImage.image = UIImage(named: "lamp")
                    cell.productName.text = "Product"
                }
            }else if indexPath.row == 1 {
                if singleItem?.haveMaintenance == "0" {
                    cell.isHidden = true
                }else if singleItem?.haveMaintenance == "1" {
                    cell.catImage.image = UIImage(named: "support")
                    cell.productName.text = "Maintenance Service"
                }
            }else if indexPath.row == 2 {
                if singleItem?.haveEmergency == "0" {
                    cell.isHidden = true
                }else if singleItem?.haveMaintenance == "1" {
                    cell.catImage.image = UIImage(named: "siren")
                    cell.productName.text = "Emergency"
                }
            }
            return cell
        }else {
            return categoriesDetailsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return subCatTabelView.frame.height / 3
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = productVC(nibName: "productVC", bundle: nil)
            vc.singleItem = singleItem
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = maintenanceVC(nibName: "maintenanceVC", bundle: nil)
            vc.singleItem = singleItem
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = emergencyServicesVC(nibName: "emergencyServicesVC", bundle: nil)
            vc.singleItem = singleItem
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
