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
private let kHeaderH : CGFloat = 50
private let kGameViewH : CGFloat = 90
private let GameCellID = "GameCellID"
private let HeaderCellID = "HeaderCellID"
class GameViewController: UIViewController {
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let topView = CollectionHeaderView.collectionHeaderView()
        topView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenW, height: kHeaderH)
        topView.iconName.image = UIImage(named: "Img_orange")
        topView.labelView.text = "常用"
        topView.moreBtn.isHidden = true
        return topView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGremView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)
        loadData()
      
    }

}
//请求数据
extension GameViewController {
    func loadData () {
        gameViewModel.loadData { () -> () in
            self.collectionView.reloadData()
            let groups = self.gameViewModel.games[0..<10]
            self.gameView.groups = Array(groups)
            
        }
    }
}

extension GameViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellID, for: indexPath) as! CollectionGameCell
        cell.group = gameViewModel.games[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCellID, for: indexPath) as! CollectionHeaderView
        header.labelView.text = "全部"
        header.iconName.image = UIImage(named: "Img_orange")
        header.moreBtn.isHidden = true
        return header
    }
}
