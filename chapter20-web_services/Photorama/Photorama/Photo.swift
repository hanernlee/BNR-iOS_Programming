//
//  Photo.swift
//  Photorama
//
//  Created by Christopher Lee on 22/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
        
    }
}
