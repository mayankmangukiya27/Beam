//
//  PostScanVC.swift
//  BeamApp
//
//  Created by Mayank Mangukiya on 26/10/21.
//

import UIKit

class PostScanVC: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    
 
    @IBOutlet weak var reScanButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
        reScanButton.addGradient(withColors: [UIColor.AppColor.primaryDark, UIColor.red])
      
      
    }

 
    @IBAction func tappedReScanButton(_ sender: Any) {
        let vc = ScanVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedConfirmButton(_ sender: Any) {
        let vc = HomeScreenProductVC()
        self.navigationController?.pushViewController(vc, animated: true)
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
