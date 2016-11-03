//
//  PageContentView.swift
//  ZhiBo
//
//  Created by mac on 16/10/30.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    
    func pageContentView(_ contentView : PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}
private let contentCellID = "contentCellID"
class PageContentView: UIView {
    //是否禁止执行代理方法
    var isYes:Bool = false
    weak var delegate:PageContentViewDelegate?
    fileprivate var startOffsetX :CGFloat = 0
    fileprivate var childVCs:[UIViewController]
    fileprivate weak var prententVC:UIViewController?
    //MARK:-懒加载属性
    fileprivate  lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = self!.bounds.size
        layout.scrollDirection = .horizontal
        let collecton = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collecton.showsHorizontalScrollIndicator = false
        collecton.bounces = false
        collecton.isPagingEnabled = true
        collecton.dataSource = self
        collecton.delegate = self
        collecton.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collecton
    }()
    init(frame: CGRect,childVCs:[UIViewController],prententVC:UIViewController?) {
        self.childVCs = childVCs
        self.prententVC = prententVC
        super.init(frame: frame)
        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContentView {
    fileprivate func setupUI() {
        //1将子控制器添加到父控制器上
//        for childVC in childVCs {
//            prententVC.addChildViewController(childVC)
//        }
        //2创建集合视图
        addSubview(self.collectionView)
        
    }
}
//MARK:-数据源协议
extension PageContentView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //循环利用,先移除,在添加
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let chiledVC = childVCs[indexPath.item]
        chiledVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chiledVC.view)
        return cell
        
    }
}
//MARK: - 公开的方法
extension PageContentView {
    func setupSelectedIndex(_ index:Int) {
        isYes = true
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
//        collectionView.scrollRectToVisible(CGRect(origin: CGPoint(x: offsetX, y: 0), size: frame.size), animated: true)
    }
}
//MARK: - 代理
extension PageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isYes = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isYes {
            return
        }
        //1定义需要获取的数据
        var progress :CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex : Int = 0
        //2判断滑动方向
        let currecntOffsetX = scrollView.contentOffset.x
        if currecntOffsetX > startOffsetX { //左滑
            //floor  取整
            progress = currecntOffsetX / bounds.width - floor(currecntOffsetX / bounds.width)
            sourceIndex = Int(currecntOffsetX / bounds.width)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if currecntOffsetX - startOffsetX == bounds.width {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            progress = 1 - (currecntOffsetX / bounds.width - floor(currecntOffsetX / bounds.width))
            targetIndex = Int(currecntOffsetX / bounds.width)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            if currecntOffsetX - startOffsetX == -bounds.width {
                progress = 1
               sourceIndex = targetIndex
            }
        }
        //3
//        print("1--\(progress) + 2--\(sourceIndex) + 3--\(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
