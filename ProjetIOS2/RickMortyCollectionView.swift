//
//  RickMortyCollectionView.swift
//  ProjetIOS2
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit

class RickMortyCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func numberOfItems(inSection section: Int) -> Int {
        return 5
    }
    
    
    override func cellForItem(at indexPath: IndexPath) -> RickMortyCollectionViewCell? {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "RickMortyCel", for: indexPath) as! RickMortyCollectionViewCell
        
        cell.nom.text = "machin"
        cell.type.text = "truc"
        
        
        return cell
    }
    

}
