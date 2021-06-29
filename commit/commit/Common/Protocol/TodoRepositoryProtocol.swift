//
//  Repository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

protocol TodoRepositoryProtocol {
	func fetchLists(completion: ((Result<[ListRealm], Never>) -> Void )?)
	func updateTodoStatusById(_ id: String)
	func updateTodo(_ todo: Todo)
}
