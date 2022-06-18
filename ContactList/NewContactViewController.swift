//
//  NewContactViewController.swift
//  ContactList
//
//  Created by Jay Prakash Sharma on 08/06/22.
//

import UIKit

protocol addContactProtocol {
    func addContact(addNew:Contact)
}

class NewContactViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var saveContact: UIBarButtonItem!
    
    
    //Variable
    // New Contact Data of Contact Type
    var newContact:Contact? = Contact(firstName: "", lastName: "", emailId: "", phoneNumber: 0)
    var addDelegate:addContactProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.image = UIImage(systemName: "bolt.horizontal.circle")
        firstName.delegate = self
        lastName?.delegate = self
        emailId.delegate = self
        phoneNumber.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
// Validation
    
    
    
    
    @IBAction func saveContact(_ sender: Any) {
        if phoneNumber.text?.count == 10 && firstName.text!.count >= 3{
        if let add = addDelegate{
            add.addContact(addNew: Contact(firstName: firstName.text!, lastName: lastName.text!, emailId: emailId.text!, phoneNumber: Int(phoneNumber.text!) ?? 0))
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
}
