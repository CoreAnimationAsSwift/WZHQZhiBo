//
//  GameViewController.swift
//  ZhiBo
//
//  Created by mac on 16/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10
private let kItemW :CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH :CGFloat = kItemW * 6 / 5
private let GameCellID = "GameCellID"
class GameViewController: UIViewController {
    private lazy var gameViewModel : GameViewModel = GameViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.registerNib(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        collectionView.backgroundColor = UIColor.whiteColor()
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        loadData()
    }

}
//请求数据
extension GameViewController {
    func loadData () {
        gameViewModel.loadData { () -> () in
            self.collectionView.reloadData()
        }
    }
}

extension GameViewController:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(GameCellID, forIndexPath: indexPath) as! CollectionGameCell
        cell.group = gameViewModel.games[indexPath.item]
        return cell
    }
}