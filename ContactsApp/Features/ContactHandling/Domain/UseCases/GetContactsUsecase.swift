//
//  GetContacts.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

class GetContactsUsecase : Usecase {
    typealias ReturnType = Set<Contact>;
    typealias Parameters = NoParameters;
    
    private var _contactsRepository: ContactRepository = ContactRepositoryImpl.repository;
    
    func execute(withParameters params: NoParameters) -> Set<Contact> {
        let contacts: Set<Contact> = _contactsRepository.getContacts();
        return contacts;
    }
}
