//
//  CalendarVC.swift
//  DI-App
//
//  Created by Gabriel Drai on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase
import FSCalendar
import FirebaseDatabase
import SideMenu

class CalendarVC: BaseViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var tableViewCLasses: UITableView!
    @IBOutlet weak var userCalendar: FSCalendar!
    @IBOutlet weak var SideMenuButton: UIBarButtonItem!
    
    var ref: DatabaseReference?
    var databaeHandler: DatabaseHandle?
    
    var courses : [Courses] = []
    
    
    var eventDictionary = [Date: [Courses]].self
    
    
    
    
    //    var eventDictionary : [Date : [Any] ] = Dictionary()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    
    
    //    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    //
    //        if courses.count < 0 {
    //
    //                return courses.count
    //        }
    //        else{ return 0}
    //
    //        }
    
    
    
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsin()
        self.tableViewCLasses.register(UINib(nibName: "CalendarTVCell", bundle: Bundle.main), forCellReuseIdentifier: "CalendarTVCell")
        
        tableViewCLasses.reloadData()
        userCalendar.dataSource = self
        userCalendar.delegate = self
        tableViewCLasses.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.courses.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CalendarTVCell = (tableViewCLasses.dequeueReusableCell(withIdentifier: "CalendarTVCell", for: indexPath) as? CalendarTVCell)!
        
        let classe : Courses = self.courses[indexPath.row]
        
        cell.updateCourses(classes: classe)
        
        return cell
    }
    
    
    
    deinit {
        print("\(#function)")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        
        print(date)
        print(date)
        
        
        let actualDate = calendar.selectedDate
        let fomatter = DateFormatter()
        fomatter.dateFormat = "EEEE, MMM d"
        let stringDate = fomatter.string(from: actualDate!)
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        //        print("selected dates is \(selectedDates)")
        
        self.daysLabel.text = "\(stringDate)"
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        let funcFormat = DateFormatter()
        funcFormat.dateFormat = "yyyy-MM-dd"
        let funcStringDate = funcFormat.string(from: date)
        loadClasses(funcStringDate)
    }
    
    
    func loadClasses(_ date: String) {
        
        courses = []
        let uid = Auth.auth().currentUser?.uid
        var ref = Database.database().reference()
        
        ref.child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionnary = snapshot.value as? [String:String] {
                
                if (dictionnary["Courses"]!)  == "Mobile Development" {
                    
                    ref =  Database.database().reference(fromURL:"https://di-app-14896.firebaseio.com/Courses/Mobile Development")
                    
                    ref.observe(.childAdded, with: { snapshot in
                        if let dict = snapshot.value as? [String:AnyObject] {
                            if let courseTime = dict["time"] as? String {
                                if courseTime == date {
                                    let classes = Courses(dict: dict)
                                    self.courses.append(classes)
                                }
                            }
                       }
                        DispatchQueue.main.async {
                            self.tableViewCLasses.reloadData()
                            self.userCalendar.reloadData()
                        }
                        
                    })
                    
                    
                } else if (dictionnary["Courses"]!) == "Web Development" {
                    
                    ref =  Database.database().reference(fromURL:"https://di-app-14896.firebaseio.com/Courses/Web Development")
                    ref.observe(.childAdded, with: { snapshot in
                        if let dict = snapshot.value as? [String:AnyObject] {
                            let classes = Courses(dict: dict)
                            self.courses.append(classes)
                            print(classes)
                            self.tableViewCLasses.reloadData()
                        }
                    })
                }
                
            }
        }, withCancel: nil)
    }
    
    
    
    
    //    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    //        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    //    }
    
    
    // MARK:- UITableViewDataSource
    
    
    //    var classCell: [ClassCell] =
    //        [ClassCell(name: "class1", time: Date.description("2017-12-25 10:00:00")), ClassCell(name: "class2", time: "2017-12-25 12:00:00")
    //    ]
    
    
    
    fileprivate var theme: Int = 0 {
        didSet {
            switch (theme) {
            case 0:
                self.userCalendar.appearance.weekdayTextColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.userCalendar.appearance.headerTitleColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.userCalendar.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.userCalendar.appearance.selectionColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.userCalendar.appearance.headerDateFormat = "MMMM yyyy"
                self.userCalendar.appearance.todayColor = UIColor(red: 198/255.0, green: 51/255.0, blue: 42/255.0, alpha: 1.0)
                self.userCalendar.appearance.borderRadius = 1.0
                self.userCalendar.appearance.headerMinimumDissolvedAlpha = 0.2
            case 1:
                self.userCalendar.appearance.weekdayTextColor = UIColor.red
                self.userCalendar.appearance.headerTitleColor = UIColor.darkGray
                self.userCalendar.appearance.eventDefaultColor = UIColor.green
                self.userCalendar.appearance.selectionColor = UIColor.blue
                self.userCalendar.appearance.headerDateFormat = "yyyy-MM";
                self.userCalendar.appearance.todayColor = UIColor.red
                self.userCalendar.appearance.borderRadius = 1.0
                self.userCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
            case 2:
                self.userCalendar.appearance.weekdayTextColor = UIColor.red
                self.userCalendar.appearance.headerTitleColor = UIColor.red
                self.userCalendar.appearance.eventDefaultColor = UIColor.green
                self.userCalendar.appearance.selectionColor = UIColor.blue
                self.userCalendar.appearance.headerDateFormat = "yyyy/MM"
                self.userCalendar.appearance.todayColor = UIColor.orange
                self.userCalendar.appearance.borderRadius = 0
                self.userCalendar.appearance.headerMinimumDissolvedAlpha = 1.0
            default:
                break;
            }
        }
    }
    
    
    
    
    
}
