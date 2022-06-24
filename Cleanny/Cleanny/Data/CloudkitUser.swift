//
//  CloudkitUser.swift
//  Cleanny
//
//  Created by 이채민 on 2022/06/14.
//

import Foundation
import CloudKit

struct CloudkitUser: Identifiable {
    let id: String
    var name: String
    var totalPercentage: Double
    let associatedRecord: CKRecord
    
    mutating func setName(name : String){
        self.name = name
    }
}

extension CloudkitUser {
    init?(record: CKRecord) {
        guard let name = record["name"] as? String,
              let totalPercentage = record["totalPercentage"] as? Double else { return nil }

        self.id = record.recordID.recordName
        self.name = name
        self.totalPercentage = totalPercentage
        self.associatedRecord = record
    }
}


