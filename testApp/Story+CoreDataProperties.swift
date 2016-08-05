//
//  Story+CoreDataProperties.swift
//  testApp
//
//  Created by Codreanu Inga on 8/4/16.
//  Copyright © 2016 Codreanu Inga. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Story {

    @NSManaged var buy: String?
    @NSManaged var descendants: NSNumber?
    @NSManaged var kids: NSObject?
    @NSManaged var score: NSNumber?
    @NSManaged var storyId: NSNumber?
    @NSManaged var time: NSNumber?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var url: String?
    @NSManaged var text: String?

}
