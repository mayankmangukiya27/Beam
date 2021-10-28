//
//  HomeVC.swift
//  BeamApp
//
//  Created by Mayank Mangukiya on 26/10/21.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedScanButton(_ sender: AppButton) {
        let vc = ScanVC()
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
