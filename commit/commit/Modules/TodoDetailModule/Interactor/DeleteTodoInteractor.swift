//
//  DeleteTodoInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/18.
//

import Foundation

class DeleteTodoInteractor: UseCase {
	let sheetsTodoAttributeRepository = RealmRepository<SheetsTodoAttribute>()
	let todoRepository = RealmRepository<Todo>()
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		if parameters.type == .googleSheets {
			let predicate = NSPredicate(format: "todoId = %@", argumentArray: [parameters.id])
			sheetsTodoAttributeRepository.find(predicate: predicate) { result in
				switch result {
					case .success(let attributes):
						print(attributes)
						self.sheetsTodoAttributeRepository.delete(entities: attributes)
					case .failure:
						print("failure")
				}
			}
		}
		todoRepository.delete(entities: [parameters])
		completion?(.success(()))
	}
	
}
