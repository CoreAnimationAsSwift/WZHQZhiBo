//
//  AmuseMeunView.swift
//  ZhiBo
//
//  Created by mac on 16/11/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
private let kMeunCellID = "kMeunCellID"
class AmuseMeunView: UIView {
    var groups:[AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMeunViewCell", bundle: nil), forCellWithReuseIdentifier: kMeunCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMeunView {
    class func amuseMeunView() -> AmuseMeunView {
        return Bundle.main.loadNibNamed("AmuseMeunView", owner: nil, options: nil)?.first as! AmuseMeunView
    }
}
extension AmuseMeunView :UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMeunCellID, for: indexPath) as! AmuseMeunViewCell
//        cell.backgroundColor = indexPath.item == 0 ? UIColor.red : UIColor.blue
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
        
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
