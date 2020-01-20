//
//  ContactRepository.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

protocol ContactRepository {
    static var repository: ContactRepository {
        get
    }
    
    func addContact(_: Contact);
    func removeContact(_: Contact);
    func updateContact(from: Contact, to: Contact);
    func getContacts() -> [Contact];
}
