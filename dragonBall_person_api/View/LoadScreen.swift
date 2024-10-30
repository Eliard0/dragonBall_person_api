//
//  LoadScreen.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 30/10/24.
//

import Foundation
import UIKit

class LoadScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchScreen()
        setupTitleLabel()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dragon Ball"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLaunchScreen() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [
            UIColor.orange.cgColor,
            UIColor.orange.withAlphaComponent(0.8).cgColor,
            UIColor.blue.withAlphaComponent(0.2).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
