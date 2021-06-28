//
//  MenuBarView.swift
//  TikTok
//
//  Created by Imran on 28/6/21.
//

import UIKit

class MenuBarView: UIView {
    
    let itemHeight = CGFloat(40)
    var itemWidth = CGFloat(40)
    
    var tabCout : CGFloat?
    
    var tabIcon = ["grid","heart (1)", "padlock"]
    
    var data = [0,1,2]
    
    //    private lazy var flowLayout: UICollectionViewFlowLayout = {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: itemWidth, height:itemHeight)
    //        layout.minimumLineSpacing = 10
    //        layout.minimumInteritemSpacing = 0
    //        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: 20)
    //        layout.scrollDirection = .horizontal
    //        return layout
    //    }()
    
    
    var leftHorizontaBar: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: MenuBarCell.identify)
        
        
        return collectionView
    }()
    func firstItemSelected(){
        
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        setupCollectionView()
     }
 
    func setupCollectionView(){
        addSubview(collectionView)
        collectionView.fitToSuper()
        
        setupHorizontalBar()
        collectionView.reloadData()
    }
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        addSubview(horizontalBarView)
        horizontalBarView.backgroundColor = UIColor.black
        
        leftHorizontaBar = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftHorizontaBar?.isActive = true
        
        let dataCount = data.count
        let floatData = CGFloat(dataCount)
        print("dataCount:\(dataCount)")
        
        horizontalBarView.position(bottom: bottomAnchor,insets: .init(top: 0, left: 0, bottom: -10, right: 0))
        horizontalBarView.size(height:2)
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / floatData).isActive = true
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension MenuBarView: UICollectionViewDelegate,
                       UICollectionViewDataSource,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count //arrData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.identify, for: indexPath) as! MenuBarCell
        
        cell.photoImageView.image = UIImage(named: tabIcon[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let count =
        guard let count = tabCout else { return CGSize(width: 0, height: 0) }
        return CGSize(width: collectionView.frame.size.width   / count, height: 40)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        print(indexPath)
        let dataCount = data.count
        let floatData = CGFloat(dataCount)
        let x = CGFloat(indexPath.item) * frame.width / floatData
        print("x:::\(x)")
        leftHorizontaBar?.constant = x
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
}
