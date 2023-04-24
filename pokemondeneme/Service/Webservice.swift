//
//  Webservice.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import Foundation

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping ([PokeApi]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                
                let pokemonlist = try? JSONDecoder().decode([PokeApi].self, from: data)
                print(pokemonlist)
                
                if let pokemonlist = pokemonlist {
                    completion(pokemonlist)
                }
                
            }
            
        }.resume()
        
    }
    
}
