//
//  RecommendGameView.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
private let kGrameCellID = "kGrameCellID"
class RecommendGameView: UIView {
    
    var groups :[AnchorGroup]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            let more : AnchorGroup = AnchorGroup()
            more.tag_name = "更多"
            groups?.append(more)
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        autoresizingMask = .None
        collectionView.registerNib(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGrameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
extension RecommendGameView {
    
    class func recommendGremView() -> RecommendGameView {
        
       return  NSBundle.mainBundle().loadNibNamed("RecommendGameView", owner: nil, options: nil).first as! RecommendGameView
    }
}
extension RecommendGameView :UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kGrameCellID, forIndexPath: indexPath) as! CollectionGameCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orangeColor() : UIColor.blueColor()
        cell.group = groups![indexPath.item]
        return cell
    }
}