//
//  DataViewModel.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 29/10/24.
//

import Foundation

class DataViewModel {
    private(set) var data: [Data] = []
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
                
                DispatchQueue.main.async {
                    self.updateData?()
                }
                print(dataResponse)
            } catch {
                print("Erro ao decodificar JSON: \(error)")
            }
        }.resume()
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    func data(at index: Int) -> Data {
        return data[index]
    }
    
}
