//
//  SectionModel.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import RxDataSources

enum Category: String {
    case friendRequest = "Friend Request"
    case someOtherCategory = "Other Category"
}

struct CategorySectionModel {
    var header: String
    var items: [Category]
}

extension CategorySectionModel: SectionModelType {
    typealias Item = Category

    init(original: CategorySectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
