//
//  GetContacts.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

class GetContactsUsecase : Usecase {
    typealias ReturnType = [Contact];
    typealias Parameters = NoParameters;
    
    static var shared: GetContactsUsecase = GetContactsUsecase();
    
    private var _contactsRepository: ContactRepository = ContactRepositoryImpl.repository;
    
    func execute(withParameters params: NoParameters) -> [Contact] {
        let contacts: [Contact] = _contactsRepository.getContacts();
        return contacts;
    }
}
