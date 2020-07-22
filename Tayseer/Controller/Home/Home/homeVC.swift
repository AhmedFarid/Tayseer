//
//  homeVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class homeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categouryCollectionView: UICollectionView!
    @IBOutlet weak var bageControl: UIPageControl!
    
    var cat = [sectionsData]()
    var slider = [sliderData]()
    var timer : Timer?
    var currentIndex = 0
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        categouryCollectionView.refreshControl = refreshControl
        
        setUpNavColore(false, "Home")
        refesHcart()
        
        bannerCollectionView.register(UINib(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        categouryCollectionView.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        categouryCollectionView.delegate = self
        categouryCollectionView.dataSource = self
        
        catHandelRefresh()
        sliderHandelRefresh()
        startTimer()
        
    }
    
    @objc func refresh(sender:AnyObject) {
        refesHcart()
        catHandelRefresh()
        sliderHandelRefresh()
        startTimer()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHNotification()
        refesHcart()
    }
    
    func catHandelRefresh(){
        loaderHelper()
        homeApi.categoryApi { (error, success, cat) in
            if let cat = cat {
                self.cat = cat.data ?? []
                print(cat)
                self.categouryCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func sliderHandelRefresh(){
        homeApi.sliderApi{ (error,success,slider) in
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
            return slider.count
        }else {
            return cat.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
                cell.configureCell(images: slider[indexPath.row])
                return cell
            }else {
                return bannerCell()
            }
        }else {
            if let cell = categouryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? categoryCell {
                cell.configureCell(cat: cat[indexPath.row])
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
            if cat[indexPath.row].typeSection == "0" {
                let vc = categoriesDetailsVC(nibName: "categoriesDetailsVC", bundle: nil)
                vc.singleItem = cat[indexPath.row]
                self.navigationController!.pushViewController(vc, animated: true)
            } else if cat[indexPath.row].typeSection == "1" {
                let vc = cleaningServicesVC(nibName: "cleaningServicesVC", bundle: nil)
                vc.singleItem = cat[indexPath.row]
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView{
            currentIndex = Int(scrollView.contentOffset.x / bannerCollectionView.frame.size.width)
            bageControl.currentPage = currentIndex
        }
    }
    
    
}
