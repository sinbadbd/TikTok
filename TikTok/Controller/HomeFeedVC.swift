//
//  HomeFeedVC.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit

@available(iOS 13.0, *)
class HomeFeedVC: UIViewController {
    
    let collectionView : UICollectionView = {
        //         let flowLayout = UICollectionViewFlowLayout()
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //          item.contentInsets.bottom = 201
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
//        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let flowLayout = UICollectionViewCompositionalLayout(section: section)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collection
        
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.fitToSuper()
        // collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        collectionView.backgroundColor = .white
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identify)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
 

        self.navigationController?.isNavigationBarHidden = true
        view.insetsLayoutMarginsFromSafeArea = false

        
      
        
        // Do any additional setup after loading the view.
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

 
    
}
@available(iOS 13.0, *)
extension HomeFeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identify, for: indexPath) as! HomeCollectionViewCell
        
 
        if indexPath.item % 2 == 0 {
            cell.vedioLinkView.backgroundColor = .red
        }else {
            cell.vedioLinkView.backgroundColor = .green
        }
        
   
        return cell
    }
    
    
}
