//
//  CameraPreviewVC.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit
import AVFoundation



struct FilterColor {
    let colors : UIColor
    let title: String
}


@available(iOS 13.0, *)
class CameraPreviewVC: UIViewController, RecordingDelegate {
    
    
    // MARK: - UI Components
    lazy var permissionView: AccessPermissionView = {
        return AccessPermissionView.init(frame: self.view.frame)
    }()
    
    
    var previewView = UIView()
    
    let captureButton :  UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
        return button
    }()
    
    
    let addSoundView     = UIView()
    
    let closeBtn         :  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        //        button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
        return button
    }()
    
    
    /*
     MARK:
     
     */
    var recordView: RecordButton?
    var playerView: MediaPlayerView?
    // MARK: - Variables
    let cameraManager = CameraManager()
    var videoURL: URL?
    let cornerRadius: CGFloat = 12.0
    
    var  cameraTopView : CameraTopView?
    var cameraFilterView : CameraFilterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraManager.removeAllTempFiles()
        
        setupView()
        topHeaderView()
        bottomView()
        filterViewRight(isHidden: false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
        playerView?.pause()
    }
    
    // MARK: - Setup
    func setupView(){
        if cameraManager.cameraAndAudioAccessPermitted {
            setUpSession()
        } else {
            self.view.addSubview(permissionView)
            permissionView.cameraAccessBtn.addTarget(self, action: #selector(askForCameraAccess), for: .touchUpInside)
            permissionView.microphoneAccessBtn.addTarget(self, action: #selector(askForMicrophoneAccess), for: .touchUpInside)
            permissionView.exitBtn.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        }
        
    }
    // MARK: - Access Permissions
    //    @IBAction func exit(_ sender: Any) {
    //        dismissController()
    //    }
    
    @objc func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func askForCameraAccess(){
        cameraManager.askForCameraAccess({ [weak self] access in
            guard let self = self else { return }
            if access {
                self.permissionView.cameraAccessPermitted()
                if (self.cameraManager.cameraAndAudioAccessPermitted) { self.setUpSession() }
            } else {
                self.alertCameraAccessNeeded()
            }
        })
    }
    
    @objc func askForMicrophoneAccess(){
        cameraManager.askForMicrophoneAccess({ [weak self] access in
            guard let self = self else { return }
            if access {
                self.permissionView.microphoneAccessPermitted()
                if (self.cameraManager.cameraAndAudioAccessPermitted) { self.setUpSession() }
            } else {
                self.alertCameraAccessNeeded()
            }
        })
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this function.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func setUpSession(){
        //        setupRecognizers()
        permissionView.removeFromSuperview()
        cameraManager.delegate = self
        previewView.layer.cornerRadius = cornerRadius
        cameraManager.addPreviewLayerToView(view: previewView)
        view.addSubview(previewView)
//        previewView.lay
        previewView.fitToSuper()
        
    }
    func finishRecording(_ videoURL: URL?, _ err: Error?) {
        //        recordView.isHidden = true
        //        exitBtn.isHidden = false
        //        nextBtn.alpha = 1
        //        addSoundImgView.alpha = 1
        //        addSoundLbl.alpha = 1
        //        effectsImgView.alpha = 1
        //        effectsLbl.alpha = 1
        //        addTextImgView.alpha = 1
        //        addTextLbl.alpha = 1
        //        addStickersImgView.alpha = 1
        //        addStickersLbl.alpha = 1
        //
        //        filterViewRight(isHidden: true)
        
        if let error = err {
            self.showAlert(error.localizedDescription)
        } else {
            self.videoURL = videoURL
        }
        //        self.cameraFilterView.isHidden = false
        presentPlayerView()
    }
    
    
    func presentPlayerView(){
        if let url = videoURL {
            playerView = MediaPlayerView(frame: previewView.frame, videoURL: url)
            view.addSubview(playerView!)
            playerView?.fitToSuper()
//            playerView?.backgroundColor = .red
            
            view.bringSubviewToFront(closeBtn)
            closeBtn.position(top: view.topAnchor, left: view.leadingAnchor, insets: .init(top: 50, left: 20,bottom:0, right: 0))
            closeBtn.size(width:20,height: 20)
            closeBtn.tag = CameraTapItem.closeBtn.rawValue
            closeBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
            
            
            
            let nextBtn = UIButton()
            playerView?.addSubview(nextBtn)
            nextBtn.position( bottom: playerView?.bottomAnchor, right: playerView?.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 20, right: 20))
            nextBtn.size(width:80,height: 34)
            nextBtn.setTitle("Next", for: .normal)
            nextBtn.backgroundColor = .systemRed
            nextBtn.layer.cornerRadius = 4
            nextBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
            nextBtn.tag = CameraTapItem.nextBtnVc.rawValue
            
            
            
            cameraFilterView = CameraFilterView()
            cameraFilterView?.delegate = self
            playerView!.addSubview(cameraFilterView!)
            cameraFilterView?.position(top: playerView?.topAnchor, right: playerView?.trailingAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 20))
            cameraFilterView?.size(width: 50, height: 300)
            cameraFilterView?.tag = 100
            
            
            playerView?.play()
            
            
        }
        
    }
    
    // MARK:- TOP VIEW
    private func topHeaderView (){
        cameraTopView = CameraTopView()
        view.addSubview(cameraTopView!)
        cameraTopView?.position(top: view.topAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 0))
        cameraTopView?.size(width: 120, height: 40)
        cameraTopView?.centerXInSuper()
        
        
        view.addSubview(closeBtn)
        closeBtn.position(top: view.topAnchor, left: view.leadingAnchor, insets: .init(top: 50, left: 20,bottom:0, right: 0))
        closeBtn.size(width:20,height: 20)
        closeBtn.tag = CameraTapItem.closeBtn.rawValue
        closeBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        
    }
    
    private func filterViewRight(isHidden:Bool?=false){
        cameraFilterView = CameraFilterView()
        cameraFilterView?.delegate = self
        view.addSubview(cameraFilterView!)
        cameraFilterView?.position(top: view.topAnchor, right: view.trailingAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 20))
        cameraFilterView?.size(width: 50, height: 300)
        cameraFilterView?.tag = 100
    }
    @objc func tapBtnTapped(_ sender:UIButton){
        print("sender:\(sender)")
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 0.5
        } completion: { [self] _ in
            sender.alpha = 1
            if sender.tag == CameraTapItem.addSoundbtn.rawValue {
                print(sender.tag)
            } else if sender.tag == CameraTapItem.cameraSwitchbtn.rawValue {
                print("sender.tag")
 
            } else if sender.tag == CameraTapItem.filterBtn.rawValue {
                print(sender.tag)
            }else if sender.tag == CameraTapItem.closeBtn.rawValue {
                print("\(sender.tag)")
                self.dismiss(animated: true, completion: nil)
            }else if (sender.tag == CameraTapItem.nextBtnVc.rawValue){
                let vc = VedioPostVC()
                guard let videoURL = self.videoURL else { return }
                vc.videoURL = videoURL
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    private func bottomView(){
        
        recordView = RecordButton()
        
        let recBtn = UIView()
        
        view.addSubview(recBtn)
        recBtn.position( bottom: view.bottomAnchor)
        recBtn.size(width:100,height: 100)
        //        recBtn.backgroundColor = .blue
        recBtn.centerXInSuper()
        
        recBtn.addSubview(recordView!)
        recordView?.isUserInteractionEnabled = true
        recordView?.position(
            left:recBtn.leadingAnchor,
            bottom: recBtn.bottomAnchor,right:
                recBtn.trailingAnchor,
            insets: .init(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0)
        )
        recordView?.size(height: 100, dimensionHeight:view.widthAnchor)
        //        recordView?.backgroundColor = .green
        recordView?.centerXInSuper()
        recordView?.layoutIfNeeded()
        let recordLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(recordBtnPressed(sender:)))
        recordLongPressGesture.minimumPressDuration = 0
        recordView?.addGestureRecognizer(recordLongPressGesture)
    }
    
    
    func getButton(btn:UIButton, image:UIImage) -> UIButton  {
        let btn = btn
        let image = UIImage(named: "\(image)")
        btn.setImage(image , for: .normal)
        btn.setImageTintColor(UIColor.white)
        
        return btn
    }
    
    
    
    @objc func takePhoto(_ sender: UIButton) {
        print("hiii")
        
    }
    
    func startRecording(){
        
        cameraFilterView?.alpha = 0
        cameraTopView?.alpha = 0
        //closeBtn.alpha = 0
        
//        cameraFilterView?.removeFromSuperview()
//        cameraTopView?.removeFromSuperview()
//        closeBtn.removeFromSuperview()
       
        
        recordView?.startRecordingAnimation()
        cameraManager.startRecording()
    }
    
    func stopRecording(){
        cameraManager.stopRecording()
        recordView?.stopRecodingAnimation()
    }
    @objc fileprivate func recordBtnPressed(sender: UILongPressGestureRecognizer){
        let location = sender.location(in: self.view)
        print(location)
        switch sender.state {
        case .began:
            startRecording()
        case .changed:
            recordView?.locationChanged(location: location)
        case .cancelled, .ended:
            stopRecording()
        default:
            break
        }
    }
    
    
    
}

@available(iOS 13.0, *)
extension CameraPreviewVC {
    func setupRecognizers(){
        let recordLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(recordBtnPressed(sender:)))
        recordLongPressGesture.minimumPressDuration = 0
        recordView?.addGestureRecognizer(recordLongPressGesture)
    }
}


@available(iOS 13.0, *)
extension CameraPreviewVC: CameraFilterProtocol {
    
    func isShowView() {
        print("show")
    }
    
    func isHiddenView() {
        print("hide")
    }
    
    func flipCamera() {
        print("flipCamera")
    }
    
    func filterCamera() {
        
 
        let filterView = FilterCameraDesignView()
        view.addSubview(filterView)
//        filterView.fitToSuper()

//        
        filterView.position(bottom: view.bottomAnchor)
        filterView.size(  height: 160, dimensionWidth: view.widthAnchor)
    
        
        if ( self.view?.viewWithTag(100) != nil ){
            print("contain")
            cameraFilterView?.isHidden = true
          }
         else {
//            view.addSubview(cameraFilterView!)
//            cameraFilterView?.position(top: view.topAnchor, right: view.trailingAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 20))
//            cameraFilterView?.size(width: 50, height: 300)
//            cameraFilterView?.isHidden = false
//            print("not contain")
         }
    }
    
    func flashCamera() {
        print("flipCamera")
    }
    
    
}
