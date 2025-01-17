//
//  AddTasksViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 03/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddTasksViewController: UIViewController {

    @IBOutlet weak var subjectNameTextField: UITextField! // This contains the subject name text field.
    @IBOutlet weak var teacherTextField: UITextField! // This contains the teacher name.
    @IBOutlet weak var roomNumberTextField: UITextField! // This contains the room number.
    @IBOutlet weak var hoursTextField: UITextField! // This contains the hours.
    @IBOutlet weak var minutesTextField: UITextField! // This contains the minutes.
    @IBOutlet weak var subView: UIView! // This is the subview of the program.
    @IBOutlet weak var weekDaysSegmentControl: UISegmentedControl! // This is how the user chooses between any of the week days.
    @IBOutlet weak var weekSegmentControl: UISegmentedControl! // This is how the user chooses betweek week A or week B.
    @IBOutlet weak var periodTextField: UITextField! // This is what sorts out the timetable slots.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        // Subviews.
        self.subView.layer.cornerRadius = 16
        self.subView.layer.borderWidth = 2.5
        self.subView.layer.borderColor = UIColor.black.cgColor
        /*
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.view.backgroundColor = UIColor.black
        }*/
    }
    
    @IBAction func addTaskBtnTapped(_ sender: Any) {
        let userUID = Auth.auth().currentUser!.uid // Retrieve the user unique identifier.
        let selectedDay = pullSelectedDay(selectedDay: weekDaysSegmentControl.selectedSegmentIndex) // This pulls the selected day for the subject.
        let selectedWeek = pullSelectedWeek() // This is the current week that the user wants the timetable slot to be put into.
        let time = "\(hoursTextField.text!):\(minutesTextField.text!)" // Get the time to put into the string for the database.
        let databaseContent: [String:String] = ["subject": subjectNameTextField.text!, "teacherName": teacherTextField.text!, "roomNum": roomNumberTextField.text!, "time":time, "day":selectedDay] // Store all content into a dictionary.
        
        Database.database().reference().child("Users").child(userUID).child("Timetable").child(selectedWeek).child(selectedDay).childByAutoId().setValue(databaseContent) // This pushed the new task to the database.
        
        // Dismiss the view controller once the button has been tapped.
        dismiss(animated: true, completion: nil)
    }
    
    func pullSelectedDay(selectedDay:Int) -> String{
        var returnValue = ""
        if (selectedDay == 0) {
            returnValue = "Monday"
        }else if (selectedDay == 1) {
            returnValue = "Tuesday"
        }else if (selectedDay == 2) {
            returnValue = "Wednesday"
        }else if (selectedDay == 3) {
            returnValue = "Thursday"
        }else if (selectedDay == 4) {
            returnValue = "Friday"
        }else if (selectedDay == 5) {
            returnValue = "Saturday"
        }else if (selectedDay == 6) {
            returnValue = "Sunday"
        }
        return returnValue
    }
    
    func pullSelectedWeek() -> String{ // This retrieves the selected week value from the week segment control.
        var returnValue = ""
        if (weekSegmentControl.selectedSegmentIndex == 0) {
            returnValue = "WeekA"
        }else if (weekSegmentControl.selectedSegmentIndex == 1) {
            returnValue = "WeekB"
        }
        return returnValue
    }
    
    @IBAction func tapGestureActivated(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
