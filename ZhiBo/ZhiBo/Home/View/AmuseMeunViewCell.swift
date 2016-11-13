//
//  AmuseMeunViewCell.swift
//  ZhiBo
//
//  Created by mac on 16/11/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kGrameCellID = "kGrameCellID"
class AmuseMeunViewCell: UICollectionViewCell {
    var groups : [AnchorGroup]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGrameCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let kItemW = collectionView.bounds.width / 4
        let kItemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: kItemW, height: kItemH)

    }
}

extension AmuseMeunViewCell :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:kGrameCellID, for: indexPath) as! CollectionGameCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.purple : UIColor.yellow
        cell.group = groups![indexPath.item]
//        cell.clipsToBounds = true
        return cell
    }
}
