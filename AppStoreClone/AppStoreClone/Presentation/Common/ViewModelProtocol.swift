//
//  ViewModelProtocol.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/12/25.
//

import Foundation
import RxRelay

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State

    var action: PublishRelay<Action> { get }
    var state: State { get set }
}
