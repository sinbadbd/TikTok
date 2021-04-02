//
//  HomeFeedVC.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit

import Firebase

@available(iOS 13.0, *)
class HomeFeedVC: UIViewController {
    
    
    /*
     let collectionView : UICollectionView = {
     
     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
     let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
     let section = NSCollectionLayoutSection(group: group)
     let flowLayout = UICollectionViewCompositionalLayout(section: section)
     
     let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
     return collection
     
     
     }()
     */
    var dataArray = [String:Any]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    private var commentsView : CommnentsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .red
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.fitToSuper()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identify)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        
        
        self.navigationController?.isNavigationBarHidden = true
        view.insetsLayoutMarginsFromSafeArea = false
        
        //        homeCell?.delegate = self
        var db: Firestore!
        db = Firestore.firestore()
        
        db.collection("posts")
            .addSnapshotListener { [self] querySnapShot, error in
                guard let document = querySnapShot?.documents else {
                    print("Error fetching document: \(error!)")
                    return
                }
 
                document.forEach { item in
                   
                    let data = item.data()
                    dataArray = data
                    print("item\(dataArray)")
                    
                    collectionView.reloadData()
                }
            }
        // [END listen_document]
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func slideUpViewTapped(){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.commentsView!.alpha = 0
                       }, completion: nil)
    }
    
    
}
@available(iOS 13.0, *)
extension HomeFeedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" dataArray.count:\( dataArray.count)")
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identify, for: indexPath) as! HomeCollectionViewCell
        
//        let data = dataArray[indexPath.item]
        
        
        cell.vedioLinkView.backgroundColor = .systemGreen
        
//        if indexPath.item % 2 == 0 {
//            cell.vedioLinkView.backgroundColor = .systemGreen
//        }else {
//            cell.vedioLinkView.backgroundColor = .systemOrange
//        }
        
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
//@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension HomeFeedVC: HomeFeedButtonClickDeleget{
    func commentButtonTapped() {
        
        
        
        let window = UIApplication.shared.keyWindow!
        self.commentsView = CommnentsView()
        window.addSubview(commentsView!)
        commentsView?.centerXInSuper()
        commentsView?.fitToSuper()
        
        commentsView?.fadeIn()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(slideUpViewTapped))
        commentsView!.addGestureRecognizer(tapGesture)
        //
        //        commentsView!.alpha = 0
        //          UIView.animate(withDuration: 0.2,
        //                         delay: 0, usingSpringWithDamping: 1.0,
        //                         initialSpringVelocity: 1.0,
        //                         options: .curveEaseInOut, animations: {
        //                            self.commentsView?.alpha = 0.8
        //          }, completion: nil)
        
    }
    
    func shareButtonTapped() {
        
    }
    
    func likeButtonPressed() {
        
    }
    
    
    func profileButtonPressed() {
        
        let vc = UserProfileVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
