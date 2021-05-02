//
//  FilterCameraDesignView.swift
//  TikTok
//
//  Created by Imran on 2/5/21.
//

import UIKit

@objc protocol didSelectIndexItem :AnyObject{
    func tapItem(index:Int)
    @objc optional func closeButtonView()
}


class FilterCameraDesignView: UIView {
    
    var delegate: didSelectIndexItem?
    
    let filterView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "disabled"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        setupUI()
        setupDelegate()
    }
    
    private func setupUI(){
        
       
        
        addSubview(filterView)
        filterView.position( left:  leadingAnchor, bottom:   bottomAnchor, right:  trailingAnchor)
        filterView.size(height:200)
        
        filterView.addSubview(closeButton)
        closeButton.position(top: filterView.topAnchor, left: filterView.leadingAnchor, insets: .init(top: 5, left: 10, bottom: 0, right: 0))
        closeButton.size(width:50,height: 30)
        closeButton.isUserInteractionEnabled = true
        closeButton.addTarget(self, action: #selector(dissmissView), for: .touchUpInside)
        delegate?.closeButtonView?()
    }
    
    private func setupDelegate(){
        filterView.addSubview(collectionView)
        collectionView.register(FilterCameraCollectionViewCell.self, forCellWithReuseIdentifier: FilterCameraCollectionViewCell.indentifier)
        
        collectionView.position(left: filterView.leadingAnchor, bottom: filterView.bottomAnchor, right: filterView.trailingAnchor, insets: .init(top: 0, left: 10, bottom: 10, right: 0))
        //        collectionView.fitToSuper()
        collectionView.size(height:120)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .green
        collectionView.allowsMultipleSelection = false
        
    }
    
    @objc func dissmissView(_ sender: UIButton){
        print(sender.tag)
        removeFromSuperview()
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
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCameraCollectionViewCell {
            //            cell.contentView.backgroundColor = .blue
            cell.isSelected = (indexPath.item != 0)
            let index = indexPath.item
            self.delegate?.tapItem(index: index)
            
        }
    }
    
    
}
extension FilterCameraDesignView: didSelectIndexItem{
    func tapItem(index: Int) {
        print("index: \(index)")
    }
    
    func closeButtonView(){
        removeFromSuperview()
    }
}
