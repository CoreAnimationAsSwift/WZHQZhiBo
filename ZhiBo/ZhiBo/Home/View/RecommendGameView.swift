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
    
    var groups :[BaseModel]? {
        didSet {
          
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGrameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
extension RecommendGameView {
    
    class func recommendGremView() -> RecommendGameView {
        
       return  Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first as! RecommendGameView
    }
}
extension RecommendGameView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGrameCellID, for: indexPath) as! CollectionGameCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orangeColor() : UIColor.blueColor()
        cell.group = groups![indexPath.item]
        return cell
    }
}
