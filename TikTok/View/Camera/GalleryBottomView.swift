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
        collectionView.position(top: containerView.topAnchor, left: containerView.leadingAnchor, right: containerView.trailingAnchor, insets: .init(top: 0, left: 5, bottom: 5, right: 0))
//        collectionView.size(height:90)
        collectionView.backgroundColor = .white
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
//        nextBtn.tag = CameraTapItem.nextBtnVc.rawValue
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
        return 10//images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCell.identify, for: indexPath) as! PhotoGalleryCell
        
//        cell.contentView.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
//        cell.contentView.layer.borderWidth = 1.0
//
//
//        cell.photoImageView.layer.cornerRadius = 4
//        cell.photoImageView.clipsToBounds = true
        //        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
        //            cell.backgroundColor = UIColor.red
        //        }
        //        else {
        //            cell.backgroundColor = UIColor.lightGray
        //        }
        
//        let data = images[indexPath.item]
//        cell.photoImageView.image = data
//
//
//        // Fetch new Images
//        if self.hasNextPage && !loading && indexPath.row == self.images.count - 1 {
//            getImages()
//        }
//
        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /// 4
//        let lay = collectionViewLayout as! UICollectionViewFlowLayout
//        /// 5
//        let widthPerItem = collectionView.frame.width / 4 - lay.minimumInteritemSpacing
//        /// 6
//        return CGSize(width: widthPerItem  - 10, height: 100)
        
        return CGSize(width:80, height: 80)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
       
        
//        delegate?.selectGallery(index: indexPath.item)
        
        
        //        let strData = arrData[indexPath.item]
        //
        //        if arrSelectedIndex.contains(indexPath) {
        //            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
        //            arrSelectedData = arrSelectedData.filter { $0 != strData}
        //        }
        //        else {
        //            arrSelectedIndex.append(indexPath)
        //            arrSelectedData.append(strData)
        //        }
        //
        //        collectionView.reloadData()
    }
}
