//
//  PageTitleView.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kscrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

protocol PageTitleViewDelegate : class {
    
    func PageTitle(titelView : PageTitleView, selectedIndex index : Int)
}

class PageTitleView: UIView {
    
    weak var delegate :PageTitleViewDelegate?
    
    private var index :Int = 0
    //标题数组
    private var titles:[String]
    //
    private lazy var titleLables:[UILabel] = [UILabel]()
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
    }()
    private lazy var scrollLine:UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView {
    private func setupUI() {
        //1UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //
        setupTitleLables()
        //dixian
        setupBottonLineAndScrollLine()
    }
    private func setupTitleLables() {
        let lableH:CGFloat = frame.height - kscrollLineH
        let lableY:CGFloat = 0
        for(index,title) in titles.enumerate() {
            let lable = UILabel()
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFontOfSize(16.0)
            lable.textColor = UIColor.darkGrayColor()
            lable.textAlignment = .Center
            //frame
            let lableW:CGFloat = frame.width / CGFloat(titles.count)
            let lableX:CGFloat = CGFloat(index) * lableW
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            addSubview(lable)
            titleLables.append(lable)
            //label点击事件
            lable.userInteractionEnabled = true
            let tipGst = UITapGestureRecognizer(target: self, action: "lableTapGesClick:")
            lable.addGestureRecognizer(tipGst)
        }
    }
    
    @objc private func lableTapGesClick(tapGes:UITapGestureRecognizer) {
        //1获取当前label的
        guard let currentLabel =  tapGes.view as? UILabel else {return}
        //2获取老的label
        let oldLabel = titleLables[index]
        //3
        currentLabel.textColor = UIColor.orangeColor()
        oldLabel.textColor = UIColor.darkGrayColor()
        //4
        index = currentLabel.tag
        //5
        let scrollLineX = CGFloat(index) * scrollLine.bounds.width
        UIView.animateWithDuration(0.2) { () -> Void in
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6
        delegate?.PageTitle(self, selectedIndex: index)
    }
    private func setupBottonLineAndScrollLine() {
        let buttonLine = UIView()
        buttonLine.backgroundColor = UIColor.lightGrayColor()
        let lineH :CGFloat = 0.5
        buttonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttonLine)
        //2.
        scrollView.addSubview(scrollLine)
        guard let fristLabel = titleLables.first else{return}
        fristLabel.textColor = UIColor.orangeColor()
        scrollLine.frame = CGRect(x: 0, y: frame.height - kscrollLineH, width: fristLabel.frame.width, height: kscrollLineH)
    }
}
//MARK: - 公开函数
extension PageTitleView {
    func setupContentOffset(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        //1
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        //2滑块
        let moveX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3颜色的渐变
        //3.1变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //3.2
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //
        index = targetIndex
    }
}