//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import Foundation

struct PokemonListViewModel {
    let pokemonList: [PokeApi]
    
    func numberOfRowsInSection() -> Int {
        return self.pokemonList.count
     }
     
     func pokemonAtIndex(_ index: Int) -> PokemonViewModel {
         let pokemons = self.pokemonList[index]
         return PokemonViewModel(pokemons)
     }
}



extension PokemonListViewModel {
  /*
    func numberOfRowsInSection() -> Int {
          return self.cryptoCurrencyList.count
      }
      
      func cryptoAtIndex(_ index: Int) -> CryptoViewModel {
          let crypto = self.cryptoCurrencyList[index]
          return CryptoViewModel(crypto)
      }
 */
    
}

struct PokemonViewModel {
    let pokemonApi: PokeApi
    
    init(_ pokemons: PokeApi) {
        self.pokemonApi = pokemons
    }
    
    var id: Int {
        return self.pokemonApi.id
    }
    
    var num: String {
        return self.pokemonApi.num
    }
    
    var name: String {
        return self.pokemonApi.name
    }
    
    var img: String {
        return self.pokemonApi.img
    }
    
    var type: [TypeElement]{
        
        return  self.pokemonApi.type
    }
    var height: String {
        return self.pokemonApi.height
    }
    var weight: String {
        return self.pokemonApi.weight
    }
    var nextEvolution: [Evolution]?{
        
        return  self.pokemonApi.nextEvolution
    }
    var prevEvolution: [Evolution]?{
        
        return  self.pokemonApi.prevEvolution
    }
    
}


extension PokemonViewModel {
    /*
     init(_ crypto: CryptoCurrency) {
        self.crytpoCurrency = crypto
    }
     */
}

extension PokemonViewModel {
    /*
    var name: String {
          return self.crytpoCurrency.currency
      }
      
      var price: String {
          return self.crytpoCurrency.price
      }
 */
    
}

