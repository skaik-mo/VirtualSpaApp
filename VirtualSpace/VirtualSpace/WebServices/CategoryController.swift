//
//  CategoryController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class CategoryController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Category)

    func getCategories(isShowLoder: Bool = true, success: @escaping ((_ categories: [Category]) -> Void)) -> FirebaseFirestoreController {
        return referance.getDocuments(isShowLoder: isShowLoder) { objects in
            var categories: [Category] = []
            objects.forEach { object in
                if let category = Category.init(dictionary: object as? [String: Any]) {
                    categories.append(category)
                }
            }
            success(categories)
        }
    }

}
