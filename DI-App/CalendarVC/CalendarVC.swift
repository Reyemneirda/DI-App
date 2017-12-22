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

class CalendarVC: BaseViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userCalendar: FSCalendar!
  
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    deinit {
        print("\(#function)")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
  
   
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2,20][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = ["cell_month", "cell_week"][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            return cell
        }
    }
    
    
    // MARK:- UITableViewDelegate
    
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK:- Target actions
    
   
    
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
    
    
    
    
    
    
    
 
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return classCell.count
//    }
    
    
    
    
}
