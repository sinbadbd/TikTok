//
//  SliderCollectionView.swift
//  TikTok
//
//  Created by Imran on 25/6/21.
//

import UIKit

class SliderCollectionView: UIView {
    
    //    var arrData = ["String","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123"]
    var arrData = ["123","123","123","123","123","123","123"]
    
    var cellScale:CGFloat = 0.7
    
    
    let collectionMargin = CGFloat(16)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(150)
    var itemWidth = CGFloat(300)
    var currentItem = 0
    
    
    var itemCellSize: CGSize = CGSize(width: 322, height: 170)
    var itemCellsGap: CGFloat = 10
 
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height:itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: 20)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        // collectionView.register(SomeCell.self)
        return collectionView
    }()
    
    private var currentIndex: Int = 0
    
    
    func setupUI(){
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: PhotoGalleryCell.identify)
        collectionView.fitToSuper()
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SliderCollectionView: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCell.identify, for: indexPath) as! PhotoGalleryCell
        cell.photoImageView.backgroundColor = .blue
        cell.photoImageView.layer.cornerRadius = 8
        
        return cell
    }
 
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView == collectionView else { return }
        
        let pageWidth = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        currentIndex = Int(scrollView.contentOffset.x / pageWidth)
    }
    
    //MARK:: THIS FUNCTION WORKING ===================================================================
  
    ///https://stackoverflow.com/questions/22895465/paging-uicollectionview-by-cells-not-screen
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = collectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        // if velocity.x > 0 && (Get the number of items from your data) > index.row + 1 {
        if velocity.x > 0 && collectionView.numberOfItems(inSection: 0) > index.row + 1 {
           index.row += 1
        } else if velocity.x == 0 {
            let cell = collectionView.cellForItem(at: index)!
            let position = collectionView.contentOffset.x - cell.frame.origin.x
            if position > cell.frame.size.width / 2 {
               index.row += 1
            }
        }
        
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true )
    }
    
    
}
