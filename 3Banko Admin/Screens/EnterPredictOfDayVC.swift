//
//  EnterPredictOfDayVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class EnterPredictOfDayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gunun Tahminleri"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPredict))
        view.backgroundColor = .systemRed
    }
    
    @objc func addNewPredict() {
        print("DEBUG: Add new predict button.")
    }

}
