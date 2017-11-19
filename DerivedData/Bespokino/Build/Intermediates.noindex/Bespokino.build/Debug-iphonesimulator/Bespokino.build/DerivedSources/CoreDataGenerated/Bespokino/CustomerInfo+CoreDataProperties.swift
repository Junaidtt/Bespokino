//
//  CustomerInfo+CoreDataProperties.swift
//  
//
//  Created by Bespokino on 11/18/2560 BE.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CustomerInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerInfo> {
        return NSFetchRequest<CustomerInfo>(entityName: "CustomerInfo")
    }

    @NSManaged public var modelNo: Int16
    @NSManaged public var userId: Int32

}
