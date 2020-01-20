//
//  ViewController.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    private var contacts: [Contact]?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        contacts = GetContactsUsecase.shared.execute(withParameters: NoParameters());
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts!.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath);
        
        let currentContact = contacts![indexPath.row];
        
        (cell as! HomeTableViewCell).firstNameLabel.text = currentContact.firstName;
        (cell as! HomeTableViewCell).lastNameLabel.text = (currentContact.lastName ?? "");
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharedContact.contact = contacts![indexPath.row];
        
        performSegue(withIdentifier: "displayDetailsSegue", sender: nil);
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DisplayContactViewController;
        dest.contact = SharedContact.contact;
    }
}

