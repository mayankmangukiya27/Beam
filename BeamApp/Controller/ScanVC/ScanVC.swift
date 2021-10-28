//
//  ScanVC.swift
//  BeamApp
//
//  Created by Mayank Mangukiya on 26/10/21.
//

import UIKit
import AVFoundation

class ScanVC: BaseVC,AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var cameraViews: UIImageView!
    @IBOutlet weak var cameraView: UIView!
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
   
    var previewView : UIView!
    var boxView:UIView!
    let myButton: UIButton = UIButton()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        reStart()
       
       
        
    }
    
    
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedScanButton(_ sender: Any) {
        let vc = PostScanVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func reStart(){
        //view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            //productSCanVC.didScannerOpen = false

            return
        }



        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.cameraView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)


        cameraView.bringSubviewToFront(cameraViews)
        cameraView.bringSubviewToFront(imageLogo)
        view.bringSubviewToFront(bottomView)
        //        view.bringSubviewToFront(cancelBtn)
        captureSession.startRunning()
    }
    @IBOutlet weak var bottomView: UIView!
//
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
