//
//  ViewController.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var previewView = UIView()
    var captureImageView = UIImageView()
    
    let captureButton :  UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
        return button
    }()
    
    let cameraFilterView = UIView()
    let addSoundView     = UIView()
    
    let closeBtn         :  UIButton = {
        let button = UIButton()
        
        //        button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
        return button
    }()
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        topHeaderView()
        bottomView()
        filterViewRight()
    }
 
    private func topHeaderView (){
        view.addSubview(addSoundView)
        addSoundView.position(top: view.topAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 0))
        addSoundView.size(width: 120, height: 40)
        addSoundView.centerXInSuper()
        addSoundView.backgroundColor = .init(white: 0, alpha: 0.3)
        addSoundView.layer.cornerRadius = 8
        
        let iconSound = UIImageView(image: UIImage(named: "music.note"))
        addSoundView.addSubview(iconSound)
        iconSound.position(left: addSoundView.leadingAnchor,insets: .init(top: 0, left: 10, bottom: 0, right: 0))
        iconSound.size(width:20, height: 20)
        iconSound.backgroundColor = .red
        iconSound.centerYInSuper()
        
        let addSoundTitle = UILabel()
        addSoundView.addSubview(addSoundTitle)
        addSoundTitle.position(left: iconSound.leadingAnchor,insets: .init(top: 0, left: 30, bottom: 0, right: 0))
        addSoundTitle.centerYInSuper()
        addSoundTitle.text = "Add Sound"
        addSoundTitle.font = .systemFont(ofSize: 12)
        addSoundTitle.textColor = .white
    }
    
    private func filterViewRight(){
        view.addSubview(cameraFilterView)
        cameraFilterView.position(top: view.topAnchor, right: view.trailingAnchor, insets: .init(top: 40, left: 0, bottom: 0, right: 20))
        cameraFilterView.size(width: 50, height: 300)
//        cameraFilterView.backgroundColor = .blue
        
        
        let flipButton = UIButton()
        cameraFilterView.addSubview(flipButton)
        flipButton.position(top: cameraFilterView.topAnchor, insets: .init(top: 5, left: 5, bottom: 0, right: 5))
         flipButton.centerXInSuper()
        flipButton.size(width:36, height: 36)
        let btnImage = UIImage(named: "flip")
        flipButton.setImage(btnImage , for: .normal)
        flipButton.setImageTintColor(UIColor.white)
        
        
        let speedButton = UIButton()
        cameraFilterView.addSubview(speedButton)
        speedButton.position(top: flipButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        speedButton.centerXInSuper()
        speedButton.size(width:36, height: 36)
        let speedButtonBtnImage = UIImage(named: "speed")
        speedButton.setImage(speedButtonBtnImage , for: .normal)
        speedButton.setImageTintColor(UIColor.white)
        
        
        
        
        let FiltersButton = UIButton()
        cameraFilterView.addSubview(FiltersButton)
        FiltersButton.position(top: speedButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        FiltersButton.centerXInSuper()
        FiltersButton.size(width:36, height: 36)
        let FiltersButtonButtonBtnImage = UIImage(named: "image")
        FiltersButton.setImage(FiltersButtonButtonBtnImage , for: .normal)
        FiltersButton.setImageTintColor(UIColor.white)

    }
    private func bottomView(){
        
        view.addSubview(captureButton)
        captureButton.position(  bottom: view.bottomAnchor,insets: .init(top: 0, left: 20, bottom: 60, right: 20))
        captureButton.centerXInSuper()
        captureButton.size(width:80, height: 80)
        captureButton.layer.cornerRadius = 30
        let btnImage = UIImage(named: "capture-button")
        captureButton.setImage(btnImage , for: .normal)
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamrera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
 
    
    func getButton(btn:UIButton, image:UIImage) -> UIButton  {
        let btn = btn
        let image = UIImage(named: "\(image)")
        btn.setImage(image , for: .normal)
        btn.setImageTintColor(UIColor.white)
        
        return btn
    }
    
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    
    @objc func takePhoto(_ sender: UIButton) {
        print("hiii")
        
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        
        DispatchQueue.main.async {
            let vc = CameraPreviewVC()
            vc.image = self.image
            print(self.image)
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    

    
    
}


extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            self.image = UIImage(data: imageData)
            print(imageData)

        }
    }
    
}
