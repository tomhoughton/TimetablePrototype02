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
    @IBOutlet weak var subView: UIView!
    
    let selectedDay = "Monday"
    
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
    }
    
    @IBAction func addTaskBtnTapped(_ sender: Any) {
        let userUID = Auth.auth().currentUser!.uid // Retrieve the user unique identifier.
        let time = "\(hoursTextField.text!):\(minutesTextField.text!)" // Get the time to put into the string for the database.
        let databaseContent: [String:String] = ["subject": subjectNameTextField.text!, "teacherName": teacherTextField.text!, "roomNum": roomNumberTextField.text!, "time":time] // Store all content into a dictionary.
        
        Database.database().reference().child("Users").child(userUID).child("Timetable").child(selectedDay).childByAutoId().setValue(databaseContent) // This pushed the new task to the database.
        
        // Dismiss the view controller once the button has been tapped.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGestureActivated(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}