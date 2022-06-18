//
//  ViewController.swift
//  ContactList
//
//  Created by Jay Prakash Sharma on 08/06/22.
//

import UIKit

class ViewController: UIViewController{
    
    //Outlet
    @IBOutlet weak var totalContact: UILabel!
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var selectAll: UIBarButtonItem!
    @IBOutlet weak var addContact: UIBarButtonItem!
    
    var selectedIndex : IndexPath?
    
    // Contact Data of dictionary type
    var contactData = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contactTableView.dataSource = self
        contactTableView.delegate = self
        contactTableView.tableFooterView = UIView()
        // Total number of contact
        selectAll.isEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("in view did appear")
        contactTableView.reloadData()
        totalContact.text = "Total Contact \n \(contactData.count)"
    }
    
    // Add Contact Button Action
    @IBAction func addContact(_ sender: Any) {
        if let NewContactViewController = storyboard?.instantiateViewController(identifier: "NewContactViewController") as? NewContactViewController {
            NewContactViewController.addDelegate = self
            self.navigationController?.pushViewController(NewContactViewController, animated: true)
        }
    }
}

// Extending ViewController to conform UITableView Protocol
extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.contactData[indexPath.row].firstName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let selectedRow = contactData[indexPath.row]
        if let DetailviewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            DetailviewController.contactDetail = selectedRow
            DetailviewController.delegate = self
            DetailviewController.deleteDelegate = self
            print(selectedRow)
            self.navigationController?.pushViewController(DetailviewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
    }
    
    // Delete selected rows swipe
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && contactData.count != 0{
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            contactData.remove(at: indexPath.row)
            tableView.endUpdates()
            contactTableView.reloadData()
            totalContact.text = "Total Contact \n \(contactData.count)"
        }
    }
    
}

// Extending viewController to DetailView Protocol
extension ViewController : DetailViewProtocol {
    func updateContact(contact: Contact) {
        print("in update contact", contact)
        if let index = selectedIndex {
            contactData[index.row] = contact
        }
    }
    
    
}

// Extending viewController to addContact Protocol
extension ViewController : addContactProtocol{
    func addContact(addNew: Contact) {
        print("in add contact", addNew)
        contactData.append(addNew)
    }
}

// Extending viewController to deleteContact Protocol
extension ViewController:DeleteViewProtocol{
    func deleteContact(delete: Contact) {
        print("In delete", delete)
        contactData.removeAll()
    }
}
