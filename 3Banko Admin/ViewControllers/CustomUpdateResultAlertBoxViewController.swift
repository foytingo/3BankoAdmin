//
//  CustomUpdateResultAlertBoxViewController.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 3.11.2020.
//

import UIKit

class CustomUpdateResultAlertBoxViewController: UIViewController {

    
    let containerView = CustomAlertContainerView()
    let titleLabel = UILabel()
    
    let stackView = UIStackView()
    
    let match1 = MatchUpdateView()
    let match2 = MatchUpdateView()
    let match3 = MatchUpdateView()
    
    let okButton = UIButton()
    
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
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(okButton)
        
        configureContainerView()
        configureTitleLabel()
        configureStackView()
        configureButton()
        
        
    
    }
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 400)
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
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(match1)
        stackView.addArrangedSubview(match2)
        stackView.addArrangedSubview(match3)
        
        match1.set(predict: prediction!["predict1"] as! [String: Any])
        match2.set(predict: prediction!["predict2"] as! [String: Any])
        match3.set(predict: prediction!["predict3"] as! [String: Any])
        
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
    
    
    
    private func configureButton() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("Tamam", for: .normal)
        okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        okButton.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func okAction() {
        let results = [match1.textField.text ,match2.textField.text,match3.textField.text]
        let status = [match1.isOk,match2.isOk,match3.isOk]
        
        let date = prediction?["date"] as! String
        
        FirebaseManager.shared.updateMatchResult(date: date, results: results, status: status, isResulted: true) { (error) in
            if let error = error {
                print("DEBUG: Error: \(error)")
            } else {
                print("DEBUG: Successfulyy updated wit results.")
                self.dismiss(animated: true)
            }
        }
        
        
    }
}
