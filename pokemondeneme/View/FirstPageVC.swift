//
//  FirstPageVC.swift
//  pokemondeneme
//
//  Created by Admin on 22.04.2023.
//

import UIKit

class FirstPageVC: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       goButton.layer.cornerRadius = 10
        goButton.layer.borderWidth = 2
        goButton.layer.borderColor = UIColor.white.cgColor
        
        //let gifURL : String = "http://www.gifbin.com/bin/4802swswsw04.gif"
        let gifURL : String = "https://www.acasadocogumelo.com/wp-content/uploads/2016/07/pokegorecord.gif"
            let imageURL = UIImage.gifImageWithURL(gifURL)
            let imageView3 = UIImageView(image: imageURL)
        imageView3.frame = CGRect(x: 0, y: 200, width: 400, height: 300)
            view.addSubview(imageView3)
        
        self.view.bringSubviewToFront(goButton)
    }
    
    
    
    
    @IBAction func letsButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toLets", sender: nil)
        
    }
    
}
