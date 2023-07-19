//
//  HandlerFinish.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation

protocol HandlerFinish {
    var didFinishRequest: (() -> Void)? { get set }
    var offlineLoad: (() -> Void)? { get set }

    func handlerDidFinishRequest(handler: (() -> Void)?) -> Self
    func handlerofflineLoad(handler: (() -> Void)?) -> Self
}
