//
//  VideoView.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import UIKit
import Photos

protocol PhotoSelectedDelegate:AnyObject {
    func selectGallery(index:Int)
}

class VideoView: UIView {
    
    var tabName = ""
    
    var arrData = ["String","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123","123"] // This is your data array
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]() // This is selected cell data array
    
    
    
    var assets = [PHAsset]()
    var images = [UIImage]()
    let page = 10
    var beginIndex = 0
    
    var endIndex = 9
    var allPhotos : PHFetchResult<PHAsset>?
    var loading = false
    var hasNextPage = false
    
    
    weak var delegate: PhotoSelectedDelegate?
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupUI()
        
        // Fetch Gallery
        let options = PHFetchOptions()
        options.includeHiddenAssets = true
        let sortDescriptions = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptions]
        allPhotos = PHAsset.fetchAssets(with: .video, options: options)
        
        getImages()
        
        
    }
    func setupUI(){
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: PhotoGalleryCell.identify)
        collectionView.fitToSuper()
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true
        collectionView.reloadData()
    }
    
    func getImages(){
        endIndex = beginIndex + (page - 1)
        if endIndex > allPhotos!.count {
            endIndex = allPhotos!.count - 1
        }
        let arr = Array(beginIndex...endIndex)
        
        let indexSet = IndexSet(arr)
        fetchPhotos(indexSet: indexSet)
    }
    
    
    ///https://stackoverflow.com/questions/54560446/how-to-paginate-when-using-phasset-to-fetch-user-photo-library
    fileprivate func fetchPhotos(indexSet: IndexSet) {
        
        if allPhotos!.count == self.images.count {
            self.hasNextPage = false
            self.loading = false
            return
        }
        
        self.loading = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.allPhotos?.enumerateObjects(at: indexSet, options: NSEnumerationOptions.concurrent, using: { (asset, count, stop) in
                
                guard let weakSelf = self else {
                    return
                }
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        weakSelf.images.append(image)
                        weakSelf.assets.append(asset)
                    }
                    
                })
                if weakSelf.images.count - 1 == indexSet.last! {
                    print("last element")
                    weakSelf.loading = false
                    weakSelf.hasNextPage = weakSelf.images.count != weakSelf.allPhotos!.count
                    weakSelf.beginIndex = weakSelf.images.count
                    DispatchQueue.main.async {
                        weakSelf.collectionView.reloadData()
                    }
                }
            })
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension VideoView: UICollectionViewDelegate,
                     UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCell.identify, for: indexPath) as! PhotoGalleryCell
        
        //        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
        //            cell.backgroundColor = UIColor.red
        //        }
        //        else {
        //            cell.backgroundColor = UIColor.lightGray
        //        }
        
        let data = images[indexPath.item]
        cell.photoImageView.image = data
        
        
        // Fetch new Images
        if self.hasNextPage && !loading && indexPath.row == self.images.count - 1 {
            getImages()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = collectionView.frame.width / 4 - lay.minimumInteritemSpacing
        /// 6
        return CGSize(width: widthPerItem  - 10, height: 100)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
       
        
        delegate?.selectGallery(index: indexPath.item)
        
        
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
 
