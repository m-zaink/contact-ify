//
//  DisplayContactViewController.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 20/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class DisplayContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var contact: Contact?;
    
    var keyValuePair: [(key: String, value: String)] = Array<(key: String, value: String)>();
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var extraDetailsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        contact = SharedContact.contact!;
        updateKeyValuePairs();
        extraDetailsTableView.delegate = self;
        extraDetailsTableView.dataSource = self;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        fullNameLabel.text = getFullName()
        if let imageData = contact?.image {
            profileImageView.image = UIImage(data: imageData);
            profileImageView.roundedImage();
        }
        // Do any additional setup after loading the view.
    }
    
    private func getFullName() -> String {
        var fullName: String = contact!.firstName;
        
        if let lastName = contact!.lastName {
            fullName += (" " + lastName);
        }
        
        return fullName;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyValuePair.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extraDetailsTableViewCell", for: indexPath);
        (cell as! ExtraDetailsTableViewCell).fieldLabel.text = keyValuePair[indexPath.row].key;
        (cell as! ExtraDetailsTableViewCell).valueLabel.text = keyValuePair[indexPath.row].value;
        
        return cell;
    }
}

extension DisplayContactViewController {
    func updateKeyValuePairs() {
        if let phoneNumber = contact?.phoneNumber {
            keyValuePair.append((key: "Phone Number", value: phoneNumber))
        }
        
        if let email = contact?.email {
            keyValuePair.append((key: "Email", value: email));
        }
        
        if let company: String = contact?.company {
            if !company.isEmpty {
                keyValuePair.append((key: "Company", value: company));
            }
        }
    }
}
