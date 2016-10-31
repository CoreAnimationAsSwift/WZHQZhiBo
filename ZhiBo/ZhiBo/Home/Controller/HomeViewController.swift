//
//  HomeViewController.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {
    //懒加载属性
    private lazy var pageTitlView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.purpleColor()
        titleView.delegate = self
        return titleView
    }()
    private lazy var pageContentView:PageContentView = {[weak self] in
        let contentH :CGFloat = kScreenH - kStatusBarH - kNavgationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        for _ in 0..<3 {
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(childVC)
        }
       let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, prententVC: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        //设置UI
        setupUI()
        //
        view.addSubview(pageTitlView)
        //
        view.addSubview(pageContentView)
//        pageContentView.backgroundColor = UIColor.purpleColor()
    }

}
extension HomeViewController {
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let size = CGSize(width: 40, height: 40)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan",highlightName: "Image_scan_click",size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightName: "btn_search_clicked", size: size)
        let histiryItem = UIBarButtonItem(imageName: "image_my_history", highlightName: "Image_my_history_click", size: size)
        navigationItem.rightBarButtonItems = [qrcodeItem,searchItem,histiryItem]
        
        
    }
}
//MARK: - 代理PageTitleViewDelegate
extension HomeViewController:PageTitleViewDelegate {
    func PageTitle(titelView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setupSelectedIndex(index)
    }
}
//MARK: - 代理PageContentViewDelegate
extension HomeViewController:PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitlView.setupContentOffset(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
