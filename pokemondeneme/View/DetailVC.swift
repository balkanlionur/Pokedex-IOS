//
//  DetailVC.swift
//  pokemondeneme
//
//  Created by Admin on 17.04.2023.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var favButtonP: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var heightText: UILabel!
    @IBOutlet weak var weightText: UILabel!
    @IBOutlet weak var prevEvolutionText: UILabel!
    @IBOutlet weak var nextEvolutionText: UILabel!
    
    var pokemonImage = ""
    var pokemonNumber = ""
    var pokemonName = ""
    var pokemonType = ""
    var pokemonHeight = ""
    var pokemonWeight = ""
    var pokemonNextEvolution = ""
    var pokemonPrevEvolution = ""
    
    var isLike = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(favButtonP)
        
        if pokemonName != "" {
            numberText.text = pokemonNumber
            nameText.text = pokemonName
            typeText.text = pokemonType
            heightText.text = pokemonHeight
            weightText.text = pokemonWeight
            prevEvolutionText.text = pokemonPrevEvolution
            nextEvolutionText.text = pokemonNextEvolution
            
            
            
        }
        
        view.addSubview(imageView)
        
        imageView.imageFrom(url: URL(string:pokemonImage)!)
        
        /*
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
         */
        
        isLikePokemon()
        isBackgraoundImage()
        
        if isLike == 1 {
            
            let heartSymbolConfiguration = UIImage.SymbolConfiguration.preferringMulticolor()
            heartSymbolConfiguration.applying(UIImage.SymbolConfiguration(pointSize: 10,weight: .medium))
            let heartImage = UIImage(systemName: "star.fill",withConfiguration: heartSymbolConfiguration)
           
            favButtonP.imageView?.tintColor = .red
            favButtonP.setImage(heartImage,for: .normal)
            
        }else{
            let heartSymbolConfiguration = UIImage.SymbolConfiguration.preferringMulticolor()
            heartSymbolConfiguration.applying(UIImage.SymbolConfiguration(pointSize: 10,weight: .medium))
            let heartImage = UIImage(systemName: "star",withConfiguration: heartSymbolConfiguration)
           
            favButtonP.imageView?.tintColor = .red
            favButtonP.setImage(heartImage,for: .normal)
            
        }
        
        }
    
    @IBAction func favButton(_ sender: Any) {
        
        if isLike == 1 {
            
            let alert = UIAlertController(title: "Info", message: "Delete from favorite page", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context  = appDelegate.persistentContainer.viewContext
            
            let newLikes = NSEntityDescription.insertNewObject(forEntityName: "Likes", into: context)
            
            
            //Attributes
            
            newLikes.setValue(numberText.text!, forKey: "id")
            isLike = 1
            newLikes.setValue(isLike, forKey: "isLike")
            newLikes.setValue(nameText.text!, forKey: "name")
            newLikes.setValue(pokemonImage, forKey: "image")
            
            
            
            do{
                try context.save()
                print("success")
            }
            catch{
                print("error")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
            self.navigationController?.popViewController(animated: true)
            
            viewDidLoad()
            
        }
        
    }
    
    func isLikePokemon() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        
        let idString = numberText.text
        
        
        fetchRequest.predicate = NSPredicate(  format: "id=%@", idString!)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results =  try  context.fetch(fetchRequest)
            if results.count>0{
                for result in results as! [NSManagedObject]{
                    isLike = result.value(forKey: "isLike") as! Int
                }
                
            }
        }catch{
            print("error")
        }
    }
    
    func isBackgraoundImage() {
        
    }
    
    
    
}


