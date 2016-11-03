//
//  AmuseViewController.swift
//  ZhiBo
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kYanZhiItemH = kItemW * 4 / 3
private let kHeaderViewH :CGFloat = 50
private let kNormalCellID = "kNomarlCellID"
private let kYanZhiCellID = "kYanZhiCellID"
private let kHeaderViewID = "kHeaderViewID"
class AmuseViewController: UIViewController {
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView:UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionVYanZhiCell",bundle: nil), forCellWithReuseIdentifier: kYanZhiCellID)
        collectionView.register(UINib(nibName:"CollectionHeaderView",bundle: nil), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    //mark
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}
extension AmuseViewController {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
    //加载数据
    fileprivate func loadData() {
        self.amuseVM.loadData() {
            self.collectionView.reloadData()
        }
    }
}
extension AmuseViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.group.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.group[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = CollectionBaseCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kYanZhiCellID, for: indexPath)as! CollectionVYanZhiCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            }
        cell.anchor = amuseVM.group[indexPath.section].anchors[indexPath.item]
//        cell.backgroundColor = UIColor.blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kYanZhiItemH)
        }else {
            return CGSize(width: kItemW, height: kItemH)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//        headerView.backgroundColor = UIColor.orange
        headerView.group = amuseVM.group[indexPath.section]
        return headerView
    }
}
