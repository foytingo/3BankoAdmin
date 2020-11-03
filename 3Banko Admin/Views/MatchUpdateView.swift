//
//  MatchUpdateView.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 3.11.2020.
//

import UIKit

protocol MatchUpdateViewDelegate: class {
    func didTapSwitch()
}

class MatchUpdateView: UIView {

    let titleLabel = UILabel()
    let textField = UITextField()
    let toggleSwitch = UISwitch()
    
    var isOk: Bool = false

    weak var matchUpdateViewDelegate: MatchUpdateViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTitleLabel()
        configureTextField()
        configureToggleSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Takim 1 - Takim 2"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ornek 3-2"
        textField.textAlignment = .center
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureToggleSwitch() {
        addSubview(toggleSwitch)
        toggleSwitch.isOn = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleSwitch.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            toggleSwitch.widthAnchor.constraint(equalToConstant: 50),
        ])
        toggleSwitch.addTarget(self, action: #selector(isOkChange), for: .valueChanged)
    }
    
    @objc func isOkChange() {
        isOk = toggleSwitch.isOn
    }

    
    func set(predict: [String: Any]) {
        print((predict["isOk"] as? Bool)!)
        titleLabel.text = predict["name"] as? String
        textField.text = predict["result"] as? String
        toggleSwitch.isOn = (predict["isOk"] as? Bool)!
        isOk = (predict["isOk"] as? Bool)!
    }
}
