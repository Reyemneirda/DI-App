//
//  Classes.swift
//  DI-App
//
//  Created by Adrien Meyer on 08/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase

class Classes: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchingDataArray:Array<Classes>?
    var searching: Bool!
    var classes:Array<Classes>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ClassesCell", bundle: Bundle.main), forCellReuseIdentifier: "ClassesCell")
        loadClasses()
        
        // Do any additional setup after loading the view.
    }

    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        if self.classes == nil {
            self.searchingDataArray = nil
            return
        }
        self.searchingDataArray = self.classes!.filter({( aSpecies: Classes) -> Bool in
            // to start, let's just search by name
            return (aSpecies.title!.lowercased().range(of: searchText.lowercased()) != nil)
        })
    }
    
    private func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchText: searchString)
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.searchingDataArray?.count ?? 0
        } else {
            return self.classes?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : ClassesCell = (tableView.dequeueReusableCell(withIdentifier: "ClassesCell", for: indexPath) as? ClassesCell)!
        
        let classe : Courses = self.classes[indexPath.row]
        
        cell.updateCourses(classes: classe)
        
        return cell
    }
    
    func loadClasses() {
        
        
        let uid = Auth.auth().currentUser?.uid
        var ref = Database.database().reference()
        
        ref.child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionnary = snapshot.value as? [String:String] {
                
                if (dictionnary["Courses"]!)  == "Mobile Development" {
                    
                    ref =  Database.database().reference(fromURL:"https://di-app-14896.firebaseio.com/Courses/Mobile Development")
                    print(ref)
                    ref.observe(.childAdded, with: { snapshot in
                        if let dict = snapshot.value as? [String:AnyObject] {
                            
                            let classes = Courses(dict: dict)
                            self.classes.append(classes)
                            print(classes)
                            self.tableView.reloadData()
                            }
                    })
                    
                
                } else if (dictionnary["Courses"]!) == "Web Development" {
                    
                    ref =  Database.database().reference(fromURL:"https://di-app-14896.firebaseio.com/Courses/Web Development")
                    ref.observe(.childAdded, with: { snapshot in
                        if let dict = snapshot.value as? [String:AnyObject] {
                            let classes = Courses(dict: dict)
                            self.classes.append(classes)
                            print(classes)
                          self.tableView.reloadData()
                        }
                    })
                }
                
                }
            }, withCancel: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
