//
//  StoryArticlesTableViewController.swift
//  testApp
//
//  Created by Codreanu Inga on 8/4/16.
//  Copyright © 2016 Codreanu Inga. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import PKHUD

class StoryArticlesTableViewController: UITableViewController {
    var item: NSMutableArray!
    var object: AnyObject!
    var storyArticles = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

    
        let appDelegate: AppDelegate = ((UIApplication.sharedApplication()).delegate as! AppDelegate)
        let context : NSManagedObjectContext = appDelegate.managedObjectContext
        self.deleteAllObjectsAction()
   
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty8")
            .responseJSON { response in
                HUD.show(.Progress)
                
                
                if let JSON = response.result.value {
                    self.item = NSMutableArray()
                    self.item = JSON as? NSMutableArray
                    for object in self.item{
                        print(object)
                        Alamofire.request(.GET, "https://hacker-news.firebaseio.com/v0/item/\(object).json?print=pretty")
                            .responseJSON { response in
                                
                                if let JSON = response.result.value {
//                                    print("JSON: \(JSON)")
                                    let appDelegate: AppDelegate = ((UIApplication.sharedApplication()).delegate as! AppDelegate)
                                    let context : NSManagedObjectContext = appDelegate.managedObjectContext;
                                    let newObject = NSEntityDescription.insertNewObjectForEntityForName("Story", inManagedObjectContext: context)
                                    newObject.setValue(JSON.objectForKey("by"), forKey: "buy")
                                    newObject.setValue(JSON.objectForKey("title"), forKey: "title")
                                    newObject.setValue(JSON.objectForKey("type"), forKey: "type")
                                    newObject.setValue(JSON.objectForKey("descendants"), forKey: "descendants")
                                    newObject.setValue(JSON.objectForKey("id"), forKey: "storyId")
                                    newObject.setValue(JSON.objectForKey("kids"), forKey: "kids")
                                    newObject.setValue(JSON.objectForKey("score"), forKey: "score")
                                    newObject.setValue(JSON.objectForKey("text"), forKey: "text")
                                    newObject.setValue(JSON.objectForKey("time"), forKey: "time")
                                    newObject.setValue(JSON.objectForKey("url"), forKey: "url")
                                    
                                }
                                
                                do{
                                    try context.save()
                                    let appDelegate: AppDelegate = ((UIApplication.sharedApplication()).delegate as! AppDelegate)
                                    let context : NSManagedObjectContext = appDelegate.managedObjectContext;
                                    let fetchRequest = NSFetchRequest(entityName: "Story")
                                    fetchRequest.predicate = NSPredicate(format: "type ==  'story'")
                                    do{
                                        let  results = try context.executeFetchRequest(fetchRequest)
                                        self.storyArticles = results as! [NSManagedObject]
                                        self.tableView.reloadData()
                                    }catch{
                                        
                                    }
                                    
                                }catch{
                                    
                                }
                        }
                    }
                    
                    self.delay(2.0) {
                        // ...and once it finishes we flash the HUD for a second.
                        HUD.flash(.Progress, delay: 1.0)
                    }
//                    print("JSON: \(JSON)")
                }
        }

    }
    
    @IBAction func deleteAllObjectsAction()
    {
      
                let appDelegate: AppDelegate = ((UIApplication.sharedApplication()).delegate as! AppDelegate)
                let context : NSManagedObjectContext = appDelegate.managedObjectContext;
                let fetchRequest = NSFetchRequest()
                fetchRequest.entity = NSEntityDescription.entityForName("Story", inManagedObjectContext: context)
                fetchRequest.includesPropertyValues = false
                do {
                    if let results = try context.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                        for result in results {
                            context.deleteObject(result)
                        }
                        
                        try context.save()
                    }
                } catch {
                
        }
        
     }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyArticles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StoryArticlesTableViewCell
        let item  = storyArticles[indexPath.row]
        
        cell.titleArticles.text = item.valueForKey("title") as? String
        let kidsObject =  item.valueForKey("descendants") as! Int
  
        cell.numberComments.text = "\(kidsObject)"
        
        
        let date = NSDate(timeIntervalSince1970: item.valueForKey("time") as! Double)
        cell.dateArticles.text = timeAgoSince(date)
        

        return cell
    }
    
   
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
        if segue.identifier == "showDetailArticles" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let item  = storyArticles[indexPath!.row]
            let imageDetailController = segue.destinationViewController as! DetailArticlesViewController
            imageDetailController.urlString = item.valueForKey("url") as! String
 
            }
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
