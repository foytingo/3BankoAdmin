//
//  BOATextField.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 6.11.2020.
//

import UIKit

class BOATextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure()
        self.placeholder = placeholder
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray.cgColor
    }
}
