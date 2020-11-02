//
//  CutomAlertBoxViewController.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class CutomAlertBoxViewController: UIViewController {

    let containerView = CustomAlertContainerView()
    let titleLabel = UILabel()
    let textField = UITextField()
    let okButton = UIButton()
    
    var alertTitle: String?
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
