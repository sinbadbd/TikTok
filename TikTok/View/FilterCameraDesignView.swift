//
//  FilterCameraDesignView.swift
//  TikTok
//
//  Created by Imran on 2/5/21.
//

import UIKit

protocol didSelectIndexItem :AnyObject{
    func tapItem(index:Int)
}


class FilterCameraDesignView: UIView {
    
    var delegate: didSelectIndexItem?
    
    let filterView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let mainContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        //        view.backgroundColor = .green
        return view
    }()
    
    var callback: ((_ id: Int) -> Void)?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        
        
        
        setupUI()
        setupDelegate()
    }
    
    private func setupUI(){
        
        addSubview(mainContentView)
        //                mainContentView.fitToSuper()
        //                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleDismiss))
        //                mainContentView.addGestureRecognizer(tapGesture)
        //
        //
        //                mainContentView.addSubview(filterView)
        //                filterView.position( left: mainContentView.leadingAnchor, bottom: mainContentView.bottomAnchor, right: mainContentView.trailingAnchor)
        //                filterView.size(height:200)
        
        addSubview(filterView)
        filterView.position( left:  leadingAnchor, bottom:   bottomAnchor, right:  trailingAnchor)
        filterView.size(height:200)
    }
    
    private func setupDelegate(){
        filterView.addSubview(collectionView)
        collectionView.register(FilterCameraCollectionViewCell.self, forCellWithReuseIdentifier: FilterCameraCollectionViewCell.indentifier)
        
        collectionView.position(left: filterView.leadingAnchor, bottom: filterView.bottomAnchor, right: filterView.trailingAnchor, insets: .init(top: 0, left: 10, bottom: 10, right: 0))
        //        collectionView.fitToSuper()
        collectionView.size(height:80)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .blue
        
        
    }
    
    
    @objc func handleDismiss(){
        //       removeFromSuperview()
        
        //        if (( self.viewWithTag(100)) == nil){
        //
        //            let cameraFilterView = CameraFilterView()
        //            cameraFilterView.isHidden = false
        //            addSubview(cameraFilterView)
        //            cameraFilterView.position(top:  topAnchor, right:  trailingAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 20))
        //            cameraFilterView.size(width: 50, height: 300)
        //            cameraFilterView.isHidden = false
        //            print("not contain")
        //
        //        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FilterCameraDesignView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCameraCollectionViewCell.indentifier, for: indexPath) as! FilterCameraCollectionViewCell
        delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.tapItem(index: indexPath.item)
        
        print(indexPath.item)
        
    }
    
    
}
extension FilterCameraDesignView: didSelectIndexItem{
    func tapItem(index: Int) {
        print("index: \(index)")
    }
    
}
