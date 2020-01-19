//
//  Contact.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

class Contact{
    var firstName: String;
    var lastName: String?;
    var company: String?;
    var phoneNumber: String?;
    var email: String?;
    var image: Data?;
    
    init(firstName: String, lastName: String?, phoneNumber: String?, email: String?, company: String?, image: Data?) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.company = company;
        self.phoneNumber = phoneNumber;
        self.email = email;
        self.image = image;
    }
}

extension Contact : Hashable {
    static func == (left: Contact, right: Contact) -> Bool {
        return left.firstName == right.firstName && left.lastName == right.lastName;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(firstName);
        hasher.combine(lastName);
    }
}

extension Contact {
    func getCopy() -> Contact {
        return Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, company: company, image: image);
    }
}
