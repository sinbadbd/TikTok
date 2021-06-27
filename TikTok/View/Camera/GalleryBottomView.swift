//
//  GallerySelectedView.swift
//  TikTok
//
//  Created by Imran on 21/6/21.
//

import UIKit

protocol NextButtonDelegate:AnyObject {
    func selectedBtn()
    func isHiddenView()
}

var imageArray = [UIImage]()

class GalleryBottomView: UIView {
    
    
    weak var delegate: NextButtonDelegate?
    
    let containerView = UIView()
    let nextBtn = UIButton()
    
    let selectedGalleryCollectionView = UIView()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        //        nextBtn.tag = CameraTapItem.nextBtnVc.rawValue
    }
    
    func setupUI(){
        
        addSubview(containerView)
        containerView.position(
            top: topAnchor,
            left: leadingAnchor,
            bottom: bottomAnchor,
            right: trailingAnchor
        )
        containerView.backgroundColor = .white
        
        
        containerView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: PhotoGalleryCell.identify)
        //        collectionView.fitToSuper()
        collectionView.position(top: containerView.topAnchor, left: containerView.leadingAnchor, right: containerView.trailingAnchor, insets: .init(top: 0, left: 5, bottom: 5, right: 5))
        //        collectionView.size(height:90)
        collectionView.backgroundColor = .red
        collectionView.isHidden = true
        //        collectionView.allowsMultipleSelection = true
        collectionView.reloadData()
        
        
        
        let nextBottomView = UIView()
        containerView.addSubview(nextBottomView)
        nextBottomView.position(top:collectionView.bottomAnchor,left:containerView.leadingAnchor, bottom: containerView.bottomAnchor, right: containerView.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        nextBottomView.size(height:40)
        //        nextBottomView.backgroundColor = .systemPink
        
        nextBottomView.addSubview(nextBtn)
        nextBtn.position( bottom: nextBottomView.bottomAnchor, right: nextBottomView.trailingAnchor, insets: .init(top: 0, left: 0, bottom:5, right: 20))
        
        
        nextBtn.size(width:80,height: 34)
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nextBtn.backgroundColor = .systemGray
        nextBtn.layer.cornerRadius = 4
        nextBtn.isEnabled = false
        nextBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
    }
    
    @objc func tapBtnTapped(){
        delegate?.selectedBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GalleryBottomView: UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  imageData.count //10//images.count
    }
    
    
    fileprivate func scrollToNextItemPresed(_ collectionView: UICollectionView, _ indexPath: IndexPath, animation:Bool) {
//        self.collectionView.isPagingEnabled = false
        self.collectionView.contentSize = CGSize(width: collectionView.bounds.width * CGFloat(imageData.count), height: collectionView.bounds.height)
        self.collectionView.scrollToItem(at: IndexPath(row: indexPath.item, section: 0), at: .left, animated: animation)
//        self.collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCell.identify, for: indexPath) as! PhotoGalleryCell
 
        
        let data = imageData[indexPath.item]
        cell.photoImageView.image = data
        cell.photoImageView.layer.cornerRadius = 4
        cell.photoImageView.clipsToBounds = true
 
        scrollToNextItemPresed(collectionView, indexPath, animation: true)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:80, height: 80)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.item)
        
//        let deleteIndex = imageData[indexPath.item]
        
        imageData.remove(at: indexPath.item)
        scrollToNextItemPresed(collectionView, indexPath, animation: false)
        collectionView.reloadData()
        
//        imageData
        
//        deleteIndex.re
        
    }
}
 
