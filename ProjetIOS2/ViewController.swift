//
//  ViewController.swift
//  ProjetIOS2
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    private var textSearched: String = ""
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textSearched = searchText
        viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RickMortyCell", for: indexPath) as! RickMortyCollectionViewCell
            cell.nom.text = self.tabSerieCharacters[indexPath.row].name
            
            let url = URL(string:self.tabSerieCharacters[indexPath.row].imageURL.absoluteString)
                if let data = try? Data(contentsOf: url!)
                {
                    cell.image.image = UIImage(data: data)
                }
            
            return cell
            
    }
    
    
    private enum Section{
        case main
    }
    
    private enum Item: Hashable{
        case character(SerieCharacter)
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section,Item>!
    /*
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(testCell[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RickMortyCell", for: indexPath) as! RickMortyCollectionViewCell
        
        cell.nom.text = tabSerieCharacters[indexPath.row].name
        cell.type.text = "truc"
        
        
        return cell
    }
    */

    @IBOutlet weak var collectionView: RickMortyCollectionView!
    
    var tabSerieCharacters: [SerieCharacter] = []
    var characterModif: SerieCharacter!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        self.diffableDataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: self.collectionView, cellProvider: {
            (collectionView, indexPath, item) -> RickMortyCollectionViewCell? in
            switch item{
            case .character(let serieCharacter):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RickMortyCell", for: indexPath) as! RickMortyCollectionViewCell
                cell.nom.text = self.tabSerieCharacters[indexPath.row].name
                
                let url = URL(string:self.tabSerieCharacters[indexPath.row].imageURL.absoluteString)
                    if let data = try? Data(contentsOf: url!)
                    {
                        cell.image.image = UIImage(data: data)
                    }
                
                
                return cell
            }
        })
        
        let snapshot = createSnapshot(characters: [])
        diffableDataSource.apply(snapshot)
        
        NetworkManager.shared.fetchCharacters{
            (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            
            case .success(let paginatedElements):
                var result: PaginatedElements<SerieCharacter> = paginatedElements
                self.tabSerieCharacters = result.decodedElements as [SerieCharacter]
                
                if(self.textSearched != ""){
                for charac in self.tabSerieCharacters{
                    if(!charac.name.contains(self.textSearched)){
                        self.supprElemTabSerieCharacters(charac: charac)
                    }
                }
                }
                
                let snapshot = self.createSnapshot(characters: self.tabSerieCharacters)
                
                DispatchQueue.main.async {
                    self.diffableDataSource.apply(snapshot)
                }
                
                }
            }
        
        
        
        
    }
    
    func supprElemTabSerieCharacters(charac: SerieCharacter){
        for indexCharac in 0...self.tabSerieCharacters.count-1 {
            if charac.name == self.tabSerieCharacters[indexCharac].name {
                tabSerieCharacters.remove(at: indexCharac)
                return
            }
        }
    }
    
    
    
    private func createSnapshot(characters: [SerieCharacter]) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])

        let items = characters.map(Item.character)
        
    snapshot.appendItems(items, toSection: .main)

                return snapshot
    }
        // Do any additional setup after loading the view.
}


