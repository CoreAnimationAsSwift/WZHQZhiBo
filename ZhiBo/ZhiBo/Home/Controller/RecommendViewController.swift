//
//  RecommendViewController.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//推荐

import UIKit
private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kYanZhiItemH = kItemW * 4 / 3
private let kNormalCellID = "kNomarlCellID"
private let kYanZhiCellID = "kYanZhiCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kHeaderViewH :CGFloat = 50
class RecommendViewController: UIViewController {

    
    private lazy var collectionView:UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = kItemMargin
        layout.minimumLineSpacing = 0
        //头的尺寸
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.whiteColor()
        collectView.dataSource = self
        collectView.delegate = self
        //自动尺寸随父控件改变
        collectView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        collectView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectView.registerNib(UINib(nibName: "CollectionVYanZhiCell", bundle: nil), forCellWithReuseIdentifier: kYanZhiCellID)
        //注册头
        collectView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.purpleColor()
        setupUI()
        

    }

}
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(self.collectionView)
    }
}
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        var cell :UICollectionViewCell
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kYanZhiCellID, forIndexPath: indexPath)
            
        }else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath)
        }
//        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1取出组的头
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath)
//        headerView.backgroundColor = UIColor.greenColor()
        return headerView
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kYanZhiItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}