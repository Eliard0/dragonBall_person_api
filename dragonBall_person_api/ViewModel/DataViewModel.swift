//
//  DataViewModel.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 29/10/24.
//

import Foundation

class DataViewModel {
    private var data: [Data] = []
    private var filterData: [Data] = []
    var updateData: (()-> Void)?
    private var isLoading = false
    
    func getPerson() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://dragonball-api.com/api/characters?limit=100"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.isLoading = false }
            guard let self = self, let data = data else { return }
            
            do {
                let dataResponse = try JSONDecoder().decode(DataResponse.self, from: data)
                self.data = dataResponse.items
                self.filterData = self.data
                
                DispatchQueue.main.async {
                    self.updateData?()
                }
            } catch {
                print("Erro ao decodificar JSON: \(error)")
            }
        }.resume()
    }
    
    func filterData(by name: String){
        if name.isEmpty {
            filterData = data
        } else {
            filterData = data.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
        updateData?()
    }
    
    func numberOfItems() -> Int {
        return filterData.count
    }
    
    func data(at index: Int) -> Data {
        return filterData[index]
    }
    
}
