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

class CalendarVC: BaseViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var userCalendar: FSCalendar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
