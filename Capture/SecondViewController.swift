//
//  SecondViewController.swift
//  Capture
//
//  Created by davix on 9/3/16.
//  Copyright © 2016 geniemedialabs. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var captureSession : AVCaptureSession?
    var stillImageOuput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    @IBOutlet var CameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewLayer?.frame = CameraView.frame

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        previewLayer?.frame = CameraView.bounds
    }
    override func viewWillAppear(animated: Bool) {
   
        super.viewWillAppear(animated)
        do{
         try self.setUpCamera()
        }
        catch{
        }
        
    }

    
    func setUpCamera() throws -> Bool{
    
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        var input : AVCaptureDeviceInput? = try AVCaptureDeviceInput(device: backCamera)
        let bool : Bool? = captureSession!.canAddInput(input!)
        
        if error == nil && bool!{
            
            captureSession?.addInput(input)
            
            stillImageOuput = AVCaptureStillImageOutput()
            stillImageOuput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            captureSession?.addOutput(stillImageOuput)
                
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
            
            CameraView.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
                
            
            return true
            
        }
        return false

    }
    
    @IBOutlet var tempImageView: UIImageView!
    var didTakePhoto : Bool = false

    func didPressTakePhoto(){
        
        if let videoConnection = self.stillImageOuput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            self.stillImageOuput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    
                    
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    var dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, .RenderingIntentDefault)
                    
                    var image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    self.tempImageView.image = image
                    self.tempImageView.hidden = false
                    
                }
                
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        didPressTakeAntoher()
    }
    
    func didPressTakeAntoher(){
        
        if didTakePhoto == true{
            self.tempImageView.hidden = true
            didTakePhoto = false
            
        }else{
            captureSession!.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            
        }
        
    }


}