//
//  MainTableViewController.swift
//  HedgeFundApp
//
//  Created by Young Kwon on 3/24/16.
//  Copyright © 2016 Young Kwon. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        array.removeAll()
        
        if (searchText.characters.count == 0) {
            self.tableView.reloadData()
        }
            
        else if (searchText.characters.count == 3)
        {
            
            let url = NSURL(string: "http://edgaronline.api.mashery.com/v2/ownerships/owners.json?filter=ownername%20contains%20%22\(searchText)%22&limit=10&fields=ownername&appkey=gshvj4uptefy9ayp3ggkjptp")
            //"http://edgaronline.api.mashery.com/v2/ownerships/owners.json?filter=ownername contains \"\(searchText)\" &fields=ownername&appkey=gshvj4uptefy9ayp3ggkjptp"
            let data = NSData(contentsOfURL: url!)
            
            
            
            if (data != nil)
            {
            
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if let dictionary = object as? [String: AnyObject] {
                        readJSONObject(dictionary)
                    }
                } catch {
                    print(error)
                }
            }
        
        }

    }
    
    func readJSONObject(object: [String: AnyObject]) {
        guard let result = object["result"] as? [String: AnyObject]
        else { return }
        guard let totalrows = result["totalrows"] as? Int
        else { return }
        guard let rows = result["rows"] as? [[String: AnyObject]]
        else { return }
        
        for row in rows {
            guard let values = row["values"] as? [[String: AnyObject]],
                let rownnum = row["rownum"] as? Int
            else { return }
            for value in values{
                let name = value["value"] as? String
                array.append(name!)
                
            }
        self.tableView.reloadData()
            
        }
        /*guard let values = rows["values"] as? [[String: AnyObject]]
        else { return }
        guard let value = values["value"] as? String
        else { return }*/
        
        //print(value)

        

    }



    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)

        cell.textLabel!.text = array[indexPath.row]

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
