//
//  IntroViewController.swift
//  pokemondeneme
//
//  Created by Admin on 19.04.2023.
//

import UIKit
import AVKit
import MediaPlayer

class IntroViewController: UIViewController {

    @IBOutlet weak var infoText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoText.text = "Pokémon, 1995 yılında Satoshi Tajiri tarafından yaratıldı.Japonya kökenli bir video oyunu olarak çıkan daha sonra çizgi roman ve animeye uzananan medya imtiyazıdır. \n \n \n İlk jenerasyon 151 Pokémon'dan oluşmaktaydı. Günümüzde 9 jenerasyon ve resmi Pokémon sitesinde 1008 Pokémon bulunmaktadır. \n \n \n 2022 itibarıyla Pokémon 25. sezonda ve 1200'den fazla fazla bölümü ile devam eden anime, 23 sinema filmi, 9 kısa film, 12 seride 34 oyun ve 123'den fazla yan oyundan oluşmaktadır."
        
       
        playVideo()
       
        
    }
    
    func playVideo() {
        
     //   let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        /*
        let videoURL = Bundle.main.path(forResource: "Pokemon", ofType: "mp4")
        
        let player  = AVPlayer(url: URL(filePath: videoURL!) )
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
        player.play()
         
        */
        
    }
    
    
    
    
    @IBAction func playButton(_ sender: Any) {
        if let videoURL = Bundle.main.path(forResource: "Pokemon", ofType: "mp4"){
            let player  = AVPlayer(url: URL(filePath: videoURL) )
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = player
            
            videoPlayer.view.frame = CGRect(x: 0.0, y: 0.0, width: 200, height: 200)
            
            videoPlayer.videoGravity = .resizeAspectFill
            
            present(videoPlayer, animated: true) {
                player.play()
            }
            
        }
        
    }
    
}
