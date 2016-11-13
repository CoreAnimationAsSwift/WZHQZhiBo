//
//  RecommendViewController.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//推荐

import UIKit
private let kCycleH :CGFloat = kScreenW * 3 / 8
private let kGrameH :CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    fileprivate lazy var viewModel:ViewModel = {
       let viewModel = ViewModel()
        return viewModel
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
    
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.addSubview(grameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleH + kGrameH, left: 0, bottom: 0, right: 0)
    }
}
extension RecommendViewController {
    override func loadData() {
        baseVM = viewModel
        //加载数据
        viewModel.loadData { () -> () in
            self.collectionView.reloadData()
            var groups :[AnchorGroup]? = self.viewModel.anchorGroups
            if groups == nil {
                return
            }
            groups?.removeFirst()
            groups?.removeFirst()
            let more : AnchorGroup = AnchorGroup()
            more.tag_name = "更多"
            groups?.append(more)
            self.grameView.groups = groups
            self.stopAnimation()
            self.collectionView.isHidden = false
        }
        viewModel.loadCycleData { () -> () in
            self.cycleView.cycleModels = self.viewModel.cycleModels
        }
    }
}

