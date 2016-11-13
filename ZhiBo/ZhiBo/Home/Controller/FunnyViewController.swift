//
//  FunnyViewController.swift
//  ZhiBo
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunnyData { 
            self.collectionView.reloadData()
            self.stopAnimation()
            self.collectionView.isHidden = false
        }
    }
    
}
