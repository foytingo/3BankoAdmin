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

    let titleLabel = BOATitleLabel(size: 18, weight: .regular)
    let textField = BOATextField(placeholder: "Ornek 3-2")
    let toggleSwitch = UISwitch()
    
    var isOk: Bool = false

    weak var matchUpdateViewDelegate: MatchUpdateViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
        configureTextField()
        configureToggleSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Takim 1 - Takim 2"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureTextField() {
        addSubview(textField)

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
        titleLabel.text = predict["name"] as? String
        textField.text = predict["result"] as? String
        toggleSwitch.isOn = (predict["isOk"] as? Bool)!
        isOk = (predict["isOk"] as? Bool)!
    }
}
