//
//  BOAButton.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 6.11.2020.
//

import UIKit

class BOAButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        configure()
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

    }

}
