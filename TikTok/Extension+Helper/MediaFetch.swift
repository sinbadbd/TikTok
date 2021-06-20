//
//  MediaFetch.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import Foundation
import Photos
import UIKit

class MediaFetch  {
    var video = [String]()
    
//    var images = [UIImage]()
    var assets = [PHAsset]()
    
    static let shared = MediaFetch()
    
      init() {
        
    }
    
    func getLatestPhotos(completion completionBlock : ((_ images:[UIImage]) -> ()))   {
            let fetchPhotos = PHFetchOptions()
//            fetchPhotos.fetchLimit = 30
            let sortDescriptions = NSSortDescriptor(key: "creationDate", ascending: false)
            fetchPhotos.sortDescriptors = [sortDescriptions]
            
            let allPhotos = PHAsset.fetchAssets(with: .video, options: fetchPhotos)
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                allPhotos.enumerateObjects { (asset, count, stop) in
                    print(asset)
                    let imageManager = PHImageManager.default()
                    let targetSize = CGSize(width: 200, height: 200)
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    imageManager.requestImage(
                        for: asset,
                        targetSize: targetSize,
                        contentMode: .aspectFit,
                        options: options,
                        resultHandler: {  (image, info) in
                        // print(image)
                        if let image = image {
                            
                          //  dic.append(<#T##newElement: String##String#>)
//                            images.append(image)
//                            self.assets.append(asset)
//                            if self.selectedImage == nil {
//                                self.selectedImage = image
//                            }
                        }
                    })
                    
//                    if count == allPhotos.count - 1 {
//                        DispatchQueue.main.async {
//                            self.collectionView.reloadData()
//                        }
//                    }
                }
            }
        }
    
}
