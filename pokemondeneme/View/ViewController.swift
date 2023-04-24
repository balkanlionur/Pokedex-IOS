//
//  ViewController.swift
//  pokemondeneme
//
//  Created by Admin on 16.04.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
   
   
   
    
    private var pokemonListViewModel: PokemonListViewModel!
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var allPokemonName = [String]()
    var filteredPokemonName = [String]()
    var isSearching = false
    
    var stext = String()
    
    var irr = ""
    
    var selectedPokemonName = ""
    var selectedPokemonImage = ""
    var selectedPokemonNumber = ""
    var selectedPokemonType = ""
    var selectedPokemonHeight = ""
    var selectedPokemonWeight = ""
    var selectedPokemonNextEvolution = ""
    var selectedPokemonPrevEvolution = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        
        getData()
        
        
        
    }
    
    private func getData() {
        
     
        
       // let url = URL(string: "https://raw.githubusercontent.com/balkanlionur/Pokedex/main/pokeapiswift.json")!
        let url = URL(string: "https://raw.githubusercontent.com/balkanlionur/Pokedex/main/pokeapi3.json")!
        
        Webservice().downloadCurrencies(url: url) { pokemons in
            
            if let pokemons = pokemons {
                
                
                self.pokemonListViewModel = PokemonListViewModel(pokemonList: pokemons)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                let forCount = 0...150
                for number in forCount{
                    self.allPokemonName.append(pokemons[number].name)
                }
                
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pokemonListViewModel != nil {
            if isSearching {
                return filteredPokemonName.count
            } else {                  }
                return self.pokemonListViewModel.numberOfRowsInSection()
            
        }else{
            return 0
        }
       
     //   return self.pokemonListViewModel == nil ? 0 : self.pokemonListViewModel.numberOfRowsInSection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemonViewModel = self.pokemonListViewModel.pokemonAtIndex(indexPath.row)
        
      //  cell.nameText.text = pokemonViewModel.name
        if cell.nameText.text != "" {
            if isSearching == false{
                
                cell.tableImage.imageFrom(url: URL(string: pokemonViewModel.img)!)
            }else{
                 
                stext = filteredPokemonName[indexPath.row]
                 
                    for i in 0...150{
                         
                        
                        if stext == self.pokemonListViewModel.pokemonAtIndex(i).name{
                            
                            cell.tableImage.imageFrom(url: URL(string:self.pokemonListViewModel.pokemonAtIndex(i).img)!)
                         
                        }
                            
                    }
                
            }
        }
        
        if isSearching {
                    cell.nameText.text = filteredPokemonName[indexPath.row]
                } else {
                    cell.nameText.text = pokemonViewModel.name
                }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            
            let destinationVC = segue.destination as! DetailVC
            
            destinationVC.pokemonImage = selectedPokemonImage
            destinationVC.pokemonNumber = selectedPokemonNumber
            destinationVC.pokemonName = selectedPokemonName
            destinationVC.pokemonType = selectedPokemonType
            destinationVC.pokemonHeight = selectedPokemonHeight
            destinationVC.pokemonWeight = selectedPokemonWeight
            destinationVC.pokemonNextEvolution = selectedPokemonNextEvolution
            destinationVC.pokemonPrevEvolution = selectedPokemonPrevEvolution
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching{
            stext = filteredPokemonName[indexPath.row]
            for i in 0...150{
                if stext == self.pokemonListViewModel.pokemonAtIndex(i).name{
                    print(i)
                    let selectedPokemon = self.pokemonListViewModel.pokemonAtIndex(i)
                    selectedPokemonImage = selectedPokemon.img
                    selectedPokemonNumber = selectedPokemon.num
                    selectedPokemonName = selectedPokemon.name
                    selectedPokemonType = String(selectedPokemon.type[0].rawValue)
                    selectedPokemonHeight = selectedPokemon.height
                    selectedPokemonWeight = selectedPokemon.weight
                    selectedPokemonNextEvolution =   selectedPokemon.nextEvolution?[0].name ?? "Evolution End"
                    selectedPokemonPrevEvolution =   selectedPokemon.prevEvolution?[0].name ?? "Evolution Beginning"
                }
                    
            }
        }else{
            let selectedPokemon = self.pokemonListViewModel.pokemonAtIndex(indexPath.row)
            
          //  let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
                
                selectedPokemonImage = selectedPokemon.img
                selectedPokemonNumber = selectedPokemon.num
                selectedPokemonName = selectedPokemon.name
                selectedPokemonType = String(selectedPokemon.type[0].rawValue)
                selectedPokemonHeight = selectedPokemon.height
                selectedPokemonWeight = selectedPokemon.weight
            selectedPokemonNextEvolution =   selectedPokemon.nextEvolution?[0].name ?? "Evolution End"
            selectedPokemonPrevEvolution =   selectedPokemon.prevEvolution?[0].name ?? "Evolution Beginning"
        }
        
        
        
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
                    isSearching = false
                    tableView.reloadData()
                } else {
                    isSearching = true
                    
                    filteredPokemonName = allPokemonName.filter({$0.contains(searchBar.text ?? "")})
                  
                    tableView.reloadData()
                }
    }
    
    
    
}
