//
//  NetworkManager.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 13.01.23.
//

import Foundation

class NetworkManager {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func getData(page: Int, completion: @escaping ([Boss]) -> Void) {
        
        guard let url = URL(string: Constants.API_URL + Constants.currentPage) else { return }
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try self.decoder.decode(BossesResponse.self, from: data)
                completion(response.data)
            }
            catch {
                print(error)
            }
            
        } .resume()
    }
}
