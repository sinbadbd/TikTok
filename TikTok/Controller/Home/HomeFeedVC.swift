//
//  HomeFeedVC.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit
import Firebase
import SnapKit
import AVFoundation
import RxSwift
import Lottie

@available(iOS 13.0, *)
class HomeFeedVC: UIViewController {
    
    
    @objc dynamic var currentIndex = 0
    var oldAndNewIndices = (0,0)
    
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    var data = [Post]()
    
    
    
    var dataArray = [String:Any]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    lazy var loadingAnimation: AnimationView = {
        let animationView = AnimationView(name: "LoadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.8
        animationView.loopMode = .loop
        self.view.addSubview(animationView)
        self.view.bringSubviewToFront(animationView)
        animationView.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.width.height.equalTo(55)
        })
        return animationView
    }()
    
    private var commentsView : CommnentsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setAudioMode()
        setupUI()
        setupBinding()
        setupObservers()
        
        if let cell = collectionView.visibleCells.first as? HomeCollectionViewCell {
            cell.play()
        }
    }
    func setupUI(){
        
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.fitToSuper()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identify)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.reloadData()
        
        self.navigationController?.isNavigationBarHidden = true
        view.insetsLayoutMarginsFromSafeArea = false
  
    }
    
    /// Set up Binding
    func setupBinding(){
        // Posts
        viewModel.posts
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { posts in
                self.data = posts
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.isLoading
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                if isLoading {
//                    self.loadingAnimation.alpha = 1
//                    self.loadingAnimation.play()
                    customActivityIndicatory(self.view, startAnimate: true)
                    //hide activityIndicatorView
                   
                } else {
//                    self.loadingAnimation.alpha = 0
//                    self.loadingAnimation.stop()
                    customActivityIndicatory(self.view, startAnimate: false)
                }
            }).disposed(by: disposeBag)
        
        viewModel.error
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { err in
                self.showAlert(err.localizedDescription)
            }).disposed(by: disposeBag)
        
        ProfileViewModel.shared.cleardCache
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { cleard in
                if cleard {
                    //self.mainTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    func setupObservers(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
//

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        if let cell = collectionView.visibleCells.first as? HomeCollectionViewCell {
            cell.pause()
        }
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
//        print(" dataArray.count:\( dataArray.count)")
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identify, for: indexPath) as! HomeCollectionViewCell

        cell.configure(post: data[indexPath.row])
        cell.play()
        cell.delegate = self
//        cell.vedioLinkView.backgroundColor = .systemGreen

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - ScrollView Extension
@available(iOS 13.0, *)
extension HomeFeedVC: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //let cell = self.collectionView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0)) as? HomeCollectionViewCell
        let cell = self.collectionView.cellForItem(at: IndexPath(row: self.currentIndex, section: 0)) as? HomeCollectionViewCell
        cell?.replay()
    }
    
}


//@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension HomeFeedVC: HomeFeedButtonClickDeleget{
    func commentButtonTapped() {
        
        
        
//        let window = UIApplication.shared.keyWindow!
//        self.commentsView = CommnentsView()
//        window.addSubview(commentsView!)
//        commentsView?.centerXInSuper()
//        commentsView?.fitToSuper()
//
//        commentsView?.fadeIn()
//
//        let tapGesture = UITapGestureRecognizer(target: self,
//                                                action: #selector(slideUpViewTapped))
//        commentsView!.addGestureRecognizer(tapGesture)
//        //
        
         CommentPopUpView.init().show()

       
       // let vc =  CommentsVC()//CommentsVC()
        
        
//
        
        
//        let transition: CATransition = CATransition()
//        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.duration = 0
//           transition.timingFunction = timeFunc
//        transition.type = CATransitionType.fade
//        transition.subtype = CATransitionSubtype.fromTop
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//        self.present(vc, animated:true, completion:nil)

//        vc.present(vc, animated: true, completion: nil)
 
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
