//
//  ViewController.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 29/10/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    private let viewModel = DataViewModel()
    private var collectionView: UICollectionView!
    private var searchBar: UISearchBar!
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 200)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpSearchBar()
        setupCollectionView()
        setupBindings()
        viewModel.getPerson()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpSearchBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar personagem"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.backgroundImage = UIImage()
        
        view.addSubview(searchBar)
        
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: "DataCell")
        
        view.addSubview(collectionView)
    }
    
    private func setupBindings() {
        viewModel.updateData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterData(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCell", for: indexPath) as! DataCell
        let character = viewModel.data(at: indexPath.row)
        cell.configure(with: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = viewModel.data(at: indexPath.row)
        let viewDetail = DetailPersonViewController()
        viewDetail.dataPerson = person
        
        let backButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
        
        navigationController?.pushViewController(viewDetail, animated: true)
    }
}
