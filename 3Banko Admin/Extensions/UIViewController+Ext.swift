//
//  UIViewController+Ext.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 3.11.2020.
//

import UIKit

extension UIViewController {
    func presentCustomAlertOnMainThread(title: String, alertType: AlertType, delegate: CutomAlertBoxViewControllerDelegate, indexPath: IndexPath) {
        DispatchQueue.main.async {
            let alertVC = CutomAlertBoxViewController(title: title, alertType: alertType, indexPath: indexPath)
            alertVC.customAlertViewDelegate = delegate
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentResultCustomAlertOnMainThread(title: String, prediction: [String:Any]){
        DispatchQueue.main.async {
            let alertVC = CustomUpdateResultAlertBoxViewController(title: title, prediction: prediction)
            //alertVC.customAlertViewDelegate = delegate
            alertVC.modalPresentationStyle = .fullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
