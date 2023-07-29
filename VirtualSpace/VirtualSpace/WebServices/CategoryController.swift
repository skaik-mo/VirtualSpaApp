//
//  CategoryController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class CategoryController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Category)

    func getCategories(isShowLoader: Bool = true, success: @escaping ((_ categories: [Category]) -> Void)) -> FirebaseFirestoreController {
        return referance.fetchDocuments(isShowLoader: isShowLoader) { objects in
            var categories: [Category] = []
            objects.forEach { object in
                if let category = Category.init(dictionary: object) {
                    categories.append(category)
                }
            }
            success(categories)
        }
    }

}
