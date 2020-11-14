//
//  BOATitleLabel.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 6.11.2020.
//

import UIKit

class BOATitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)
        configure()
        font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        font = UIFont.systemFont(ofSize: 25, weight: .bold)
        textAlignment = .center
    }
    
}
