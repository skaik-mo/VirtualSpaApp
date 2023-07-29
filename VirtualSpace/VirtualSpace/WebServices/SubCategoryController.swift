//
//  SubCategoryController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class SubCategoryController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.SubCategory)

    func getSubCategories(isShowLoader: Bool = true, success: @escaping ((_ subCategories: [SubCategory]) -> Void)) -> FirebaseFirestoreController {
        return referance.fetchDocuments(isShowLoader: isShowLoader) { objects in
            var subCategories: [SubCategory] = []
            objects.forEach { object in
                if let subCategory = SubCategory.init(dictionary: object) {
                    subCategories.append(subCategory)
                }
            }
            success(subCategories)
        }
    }

}
