//
//  CutomAlertBoxViewController.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

enum AlertType {
    case dateAndTime, match, org, predict, odd
}

protocol CutomAlertBoxViewControllerDelegate: class {
    func didTapOkButton(type: AlertType, text: String, indexPath: IndexPath)
}

class CutomAlertBoxViewController: UIViewController {

    let containerView = CustomAlertContainerView()
    let titleLabel = UILabel()
    let textView = UITextView()
    let okButton = UIButton()
    
    var alertTitle: String?
    var alertType: AlertType?
    var indexPath: IndexPath?
    
    weak var customAlertViewDelegate: CutomAlertBoxViewControllerDelegate!
    
    init(title: String, alertType: AlertType, indexPath: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertType = alertType
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(okButton)
        
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureTextView()
        
    }
    
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = alertTitle ?? "Hata"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -10)
        ])
    }
    
    private func configureButton() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("Tamam", for: .normal)
        okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        okButton.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    
    @objc func okAction() {
        customAlertViewDelegate.didTapOkButton(type: alertType!, text: textView.text, indexPath: indexPath!)
        dismiss(animated: true)
    }
}
