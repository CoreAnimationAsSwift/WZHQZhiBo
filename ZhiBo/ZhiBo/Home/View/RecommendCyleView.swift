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
    var timer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            self.collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10 , section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeTimer()
            addTimer()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCyleCellID)
       
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
        let cyle = Bundle.main.loadNibNamed("RecommendCyleView", owner: nil, options: nil)?.first as! RecommendCyleView
        return cyle
    }
}
//MARK: - 数据源
extension RecommendCyleView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCyleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orangeColor() : UIColor.blueColor()
        
        return cell
        
    }
}
//MARK: - 代理
extension RecommendCyleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = Int((scrollView.contentOffset.x + kScreenW * 0.5) / kScreenW)
        if current == 0 {
            pageControl.currentPage = 0
        }else{
        pageControl.currentPage = current % (cycleModels!.count)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addTimer()
    }
    
}
extension RecommendCyleView {
    fileprivate func addTimer() {
        timer = Timer(timeInterval: 3, target: self, selector: #selector(RecommendCyleView.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    @objc fileprivate func scrollToNext () {
        //1
        let currentOffsetX = collectionView.contentOffset.x
        let offSetX =   kScreenW + currentOffsetX
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}


