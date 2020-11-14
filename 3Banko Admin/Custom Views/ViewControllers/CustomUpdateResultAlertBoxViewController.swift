//
//  CustomUpdateResultAlertBoxViewController.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 3.11.2020.
//

import UIKit

class CustomUpdateResultAlertBoxViewController: UIViewController {

    
    let containerView = CustomAlertContainerView()
    let titleLabel = BOATitleLabel(frame: .zero)
    
    let stackView = UIStackView()
    
    let match1 = MatchUpdateView()
    let match2 = MatchUpdateView()
    let match3 = MatchUpdateView()
    
    let okButton = BOAButton(title: "Tamam", color: .systemBlue)
    let cancelButton = BOAButton(title: "Iptal", color: .systemRed)
    
    var alertTitle: String?
    var prediction: [String: Any]?
    
    
    init(title: String, prediction: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.prediction = prediction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        configureContainerView()
        configureTitleLabel()
        configureStackView()
        configureButtons()
    }
    
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 430)
        ])
    }
    
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Hata"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let matchArray = [match1,match2,match3]
        for (index,match) in matchArray.enumerated() {
            stackView.addArrangedSubview(match)
            match.set(predict: prediction!["predict\(index+1)"] as! [String : Any])
        }

        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 225)
        ])
    }
    
    
    private func configureButtons() {
        view.addSubview(okButton)
        okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: okButton.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func cancelAction() {
        self.dismiss(animated: true)
    }

    
    @objc func okAction() {
        let results = [match1.textField.text ,match2.textField.text,match3.textField.text]
        let status = [match1.isOk,match2.isOk,match3.isOk]
        
        let date = prediction?["date"] as! String
        
        FirebaseManager.shared.updateMatchResult(date: date, results: results, status: status, isResulted: true) { (error) in
            if error != nil {
                self.presentAlertWithOk(message: BOAErrors.updateError.rawValue)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
}
