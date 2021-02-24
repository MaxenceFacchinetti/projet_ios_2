//
//  ViewController.swift
//  ProjetIOS2
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(testCell[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RickMortyCell", for: indexPath) as! RickMortyCollectionViewCell
        
        cell.nom.text = testCell[indexPath.row]
        cell.type.text = "truc"
        
        
        return cell
    }
    
    var testCell: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o"]

    @IBOutlet weak var collectionView: RickMortyCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    


}

