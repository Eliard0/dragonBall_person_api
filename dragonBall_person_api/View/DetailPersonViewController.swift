//
//  DetailPersonViewController.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 01/11/24.
//

import Foundation
import UIKit

class DetailPersonViewController: UIViewController {
    var dataPerson: Data?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()
    
    private lazy var baseKi: UILabel = {
        let baseKi = UILabel()
        baseKi.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        baseKi.numberOfLines = 0
        baseKi.textAlignment = .center
        baseKi.translatesAutoresizingMaskIntoConstraints = false
        
        return baseKi
    }()
    
    private lazy var maxKi: UILabel = {
        let maxKi = UILabel()
        maxKi.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        maxKi.numberOfLines = 0
        maxKi.textAlignment = .center
        maxKi.translatesAutoresizingMaskIntoConstraints = false
        
        return maxKi
    }()
    
    private lazy var race: UILabel = {
        let race = UILabel()
        race.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        race.numberOfLines = 0
        race.textAlignment = .center
        race.translatesAutoresizingMaskIntoConstraints = false
        
        return race
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        displayCharacterDetails()
    }
    
    private func setUpView(){
        setHierarchy()
        setConstrants()
    }
    
    private func setHierarchy(){
        view.addSubview(imageView)
        view.addSubview(name)
        view.addSubview(baseKi)
        view.addSubview(maxKi)
        view.addSubview(race)
    }
    
    private func setConstrants() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            baseKi.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            baseKi.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            maxKi.topAnchor.constraint(equalTo: baseKi.bottomAnchor, constant: 10),
            maxKi.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            race.topAnchor.constraint(equalTo: maxKi.bottomAnchor, constant: 10),
            race.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func displayCharacterDetails() {
        guard let dataPerson = dataPerson else { return }
        
        if let imageUrlString = dataPerson.image, let url = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            imageView.image = UIImage(named: "Image")
        }
        
        name.text = dataPerson.name
        baseKi.text = "Base Ki: \(dataPerson.ki)"
        maxKi.text = "Maximo Ki: \(dataPerson.maxKi)"
        race.text = "Raça: \(dataPerson.race)"
    }
}
