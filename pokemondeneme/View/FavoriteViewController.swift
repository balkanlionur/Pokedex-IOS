//
//  FavoriteViewController.swift
//  pokemondeneme
//
//  Created by Admin on 20.04.2023.
//

import UIKit
import CoreData
import ImageSlideshow
import ImageSlideshowKingfisher
import Kingfisher

class FavoriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var switchButton: UISwitch!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var iDArray = [String]()
    var nameArray = [String]()
    var imageArray = [String]()
    var inputArray = [KingfisherSource]()
    
    var switchOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getfav()
        snapImage()

        
    }
    
    func snapImage()  {
        for imageUrl in imageArray{
            inputArray.append(KingfisherSource(urlString: imageUrl)!)
        }
        
        
        let imageSliderShow = ImageSlideshow(frame: CGRect(x: 50, y: 60, width: self.view.frame.width * 0.70, height: self.view.frame.height * 0.70))
        
        imageSliderShow.backgroundColor = UIColor.white
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
        pageIndicator.pageIndicatorTintColor = UIColor.black
        imageSliderShow.pageIndicator = pageIndicator
        
        imageSliderShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        imageSliderShow.setImageInputs(inputArray)
        
        self.view.addSubview(switchButton)
        
        if switchOn == true{
            tableView.isHidden = true
            imageSliderShow.isHidden = false
            self.view.addSubview(imageSliderShow)
        }else{
            tableView.isHidden = false
            imageSliderShow.isHidden = true
            self.view.bringSubviewToFront(tableView)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iDArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = UITableViewCell()
       //cell.textLabel?.text = iDArray[indexPath.row]
      cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func getfav()  {
        
        iDArray.removeAll(keepingCapacity: false)
        nameArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        inputArray.removeAll(keepingCapacity: false)
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
         let results =  try  context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? String {
                        self.iDArray.append(id)
                    }
                    if let name = result.value(forKey: "name") as? String{
                        self.nameArray.append(name)
                    }
                    if let image = result.value(forKey: "image") as? String{
                        self.imageArray.append(image)
                    }
                    
                    
                    self.tableView.reloadData()
                    
                }
            }
            
        }catch{
            print("error")
        }
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
                
                let idString = iDArray[indexPath.row]
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
                
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject]{
                            if let id = result.value(forKey: "id") {
                                if id as! String == iDArray[indexPath.row]{
                                    context.delete(result)
                                    iDArray.remove(at: indexPath.row)
                                    nameArray.remove(at: indexPath.row)
                                    imageArray.remove(at: indexPath.row)
                                    self.tableView.reloadData()
                                    
                                    do{
                                     try   context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                            }
                        }
                                
                                
                                
                    }
                    
                    
                    
                }catch{
                    print("Error")
                }
        }
        
    }
    
    @IBAction func switchClicked(_ sender: UISwitch) {
        if switchButton.isOn{
            switchOn = true
        }else {
            switchOn = false
        }
        viewDidLoad()
    }
}

