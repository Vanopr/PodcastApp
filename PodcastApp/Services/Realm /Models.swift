//
//  Models.swift
//  PodcastApp
//
//  Created by Vanopr on 29.09.2023.
//

import Foundation
import RealmSwift

class LikedIdArray: Object {
    @Persisted var idArray: List<Int>

    convenience init(idArray: [Int]) {
        self.init()
        self.idArray.append(objectsIn: idArray)
    }
}
