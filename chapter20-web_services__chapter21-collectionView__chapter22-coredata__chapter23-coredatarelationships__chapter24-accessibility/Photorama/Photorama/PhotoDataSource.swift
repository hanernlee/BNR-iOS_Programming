//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Christopher Lee on 23/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.photoDescription = photo.title
        
        return cell
    }
}
