//
//  RecommendCyleView.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
private let kCyleCellID = "kCyleCellID"
class RecommendCyleView: UIView {
    var timer : NSTimer?
    var cycleModels : [CycleModel]? {
        didSet {
            self.collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = NSIndexPath(forItem: (cycleModels?.count ?? 0) * 10 , inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            removeTimer()
            addTimer()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        autoresizingMask = .None
        collectionView.registerNib(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCyleCellID)
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .Horizontal
//        collectionView.pagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
    }
    
}

//MARK: - 快速创建类方法
extension RecommendCyleView {
    class func recommendCyleView() -> RecommendCyleView {
        let cyle = NSBundle.mainBundle().loadNibNamed("RecommendCyleView", owner: nil, options: nil).first as! RecommendCyleView
        return cyle
    }
}
//MARK: - 数据源
extension RecommendCyleView :UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCyleCellID, forIndexPath: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orangeColor() : UIColor.blueColor()
        
        return cell
        
    }
}
//MARK: - 代理
extension RecommendCyleView : UICollectionViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let current = Int((scrollView.contentOffset.x + kScreenW * 0.5) / kScreenW)
        pageControl.currentPage = current % (cycleModels!.count ?? 1)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addTimer()
    }
    
}
extension RecommendCyleView {
    private func addTimer() {
        timer = NSTimer(timeInterval: 3, target: self, selector: "scrollToNext", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    @objc private func scrollToNext () {
        //1
        let currentOffsetX = collectionView.contentOffset.x
        let offSetX =   kScreenW + currentOffsetX
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}


