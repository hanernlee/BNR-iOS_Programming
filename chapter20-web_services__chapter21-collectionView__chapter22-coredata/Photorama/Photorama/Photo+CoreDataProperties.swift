//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Christopher Lee on 23/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: NSURL?
    @NSManaged public var title: String?
    @NSManaged public var viewCount: Int64

}
