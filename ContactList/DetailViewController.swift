//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Jay Prakash Sharma on 08/06/22.
//

import UIKit

//Detail View Protocol
protocol DetailViewProtocol {
    func updateContact(contact:Contact)
}

// Delete View Protocol
protocol DeleteViewProtocol {
    func deleteContact(delete:Contact)
}

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    // Variable
    var contactDetail:Contact?
    var deleteDelegate: DeleteViewProtocol?
    var delegate : DetailViewProtocol?
    
    // Outlets
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.image = UIImage(systemName: "bolt.horizontal.circle")
        
        // Do any additional setup after loading the view.
        if let detail = contactDetail {
            firstName.text = detail.firstName
            lastName.text = detail.lastName
            emailId.text = detail.emailId
            phoneNumber.text = String(detail.phoneNumber)
            saveButton.isEnabled = false
            
        }
    }
    
    // Save Contact
    @IBAction func saveContact(_ sender: Any) {
        if phoneNumber.text?.count == 10 && firstName.text!.count >= 3{
        if let update = delegate {
            update.updateContact(contact: Contact(firstName: firstName.text!, lastName: lastName.text!, emailId: emailId.text!, phoneNumber: Int(phoneNumber.text!) ?? 0 ))
        }
        self.navigationController?.popToRootViewController(animated: true)
        } else if firstName.text!.count < 3{
            let alert = UIAlertController(title: "Message", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if phoneNumber.text!.count < 10{
            let alert = UIAlertController(title: "Message", message: "Please enter valid phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if phoneNumber.text!.count > 10{
            let alert = UIAlertController(title: "Message", message: "Please enter valid phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
  }
    // Edit details
    @IBAction func editDetails(_ sender: Any) {
        firstName.isEnabled = true
        lastName.isEnabled = true
        emailId.isEnabled = true
        phoneNumber.isEnabled = true
        saveButton.isEnabled = true
        firstName.becomeFirstResponder()
        
    }
    
    //Delete Contact
    @IBAction func deleteContact(_ sender: Any) {
        if let delete = deleteDelegate{
            delete.deleteContact(delete: Contact(firstName: "", lastName: "", emailId: "", phoneNumber: 0))
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

