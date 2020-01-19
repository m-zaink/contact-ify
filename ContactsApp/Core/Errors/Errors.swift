//
//  Errors.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

enum ContactError: Error {
    case ContactAlreadyPresent(contactDetails: Contact);
    case NoSuchContactFound;
}

enum MemoryError: Error {
    case CouldNotSaveToMemory;
}
