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
private let kCycleH :CGFloat = kScreenW * 3 / 8
private let kGrameH :CGFloat = 90

class RecommendViewController: UIViewController {

    fileprivate lazy var viewModel:ViewModel = {
       let viewModel = ViewModel()
        return viewModel
    }()
    fileprivate lazy var collectionView:UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = kItemMargin
        layout.minimumLineSpacing = 0
        //头的尺寸
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.white
        collectView.dataSource = self
        collectView.delegate = self
        //自动尺寸随父控件改变
        collectView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectView.register(UINib(nibName: "CollectionVYanZhiCell", bundle: nil), forCellWithReuseIdentifier: kYanZhiCellID)
        //注册头
        collectView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectView
    }()
    fileprivate lazy var cycleView : RecommendCyleView = {
       let cycleView = RecommendCyleView.recommendCyleView()
        cycleView.frame = CGRect(x: 0, y:-(kCycleH + kGrameH) , width: kScreenW, height: kCycleH)
        
        return cycleView
    }()
    fileprivate lazy var grameView :RecommendGameView = {
       let grameView = RecommendGameView.recommendGremView()
        grameView.frame = CGRect (x: 0, y: -kGrameH, width: kScreenW, height: kGrameH)
        return grameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.purpleColor()
        setupUI()
        //加载数据
        viewModel.loadData { () -> () in
            self.collectionView.reloadData()
            
//            self.grameView.groups = self.viewModel.anchorGroup
            var groups :[AnchorGroup]? = self.viewModel.anchorGroup
            if groups == nil {
                return
            }
            groups?.removeFirst()
            groups?.removeFirst()
            let more : AnchorGroup = AnchorGroup()
            more.tag_name = "更多"
            groups?.append(more)
            self.grameView.groups = groups
            
        }
        viewModel.loadCycleData { () -> () in
            self.cycleView.cycleModels = self.viewModel.cycleModels
        }

    }

}
extension RecommendViewController {
    fileprivate func setupUI() {
        view.addSubview(self.collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(grameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleH + kGrameH, left: 0, bottom: 0, right: 0)
    }
    
}
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.anchorGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 8
//        }
//        return 4
        let group = viewModel.anchorGroup[section]
       return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = viewModel.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        var cell = CollectionBaseCell()
        //1
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kYanZhiCellID, for: indexPath) as! CollectionVYanZhiCell
        }else {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
            as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1取出组的头
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = viewModel.anchorGroup[indexPath.section]
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kYanZhiItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}
