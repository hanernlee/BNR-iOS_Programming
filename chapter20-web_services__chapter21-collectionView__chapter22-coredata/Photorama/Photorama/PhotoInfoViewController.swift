//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Christopher Lee on 23/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        
        photo.viewCount += 1
        store.saveContextIfNeeded()
        
        let label = UILabel()
        label.text = "\(photo.viewCount) views"
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
    }
}
