//
//  ViewController.swift
//  ProjetIOS2
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section{
        case LIGNE
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        
        // Do any additional setup after loading the view.
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (section, environment) -> NSCollectionLayoutSection? in
            let snapshot = self.diffableDataSource.snapshot()
            let currentSection = snapshot.sectionIdentifiers[section]
            
            switch currentSection {
            case .LIGNE:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(50))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             subitem: item,
                                                             count: 2)

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10

                return section
            }
        })

        return layout
    }
    
    


}

