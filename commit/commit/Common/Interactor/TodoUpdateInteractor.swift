//
//  TodoListUpdateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoUpdateInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	let spreadSheetTodoAttributeRepository = RealmRepository<SpreadSheetTodoAttribute>()
	let sheetPresetRepository = RealmRepository<Preset>()
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared
	) {
		self.todoRepository = todoRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		todoRepository.updateTodoStatusById(parameters.id)
		if parameters.todoType == "googleSheets" {
			print("googleSheets")
			updateSheetTodo(parameters)
		}
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
	
	func updateSheetTodo(_ todo: Todo) {
		// NOTE: もうちょっと上手く書けないかな
		var attribute: SpreadSheetTodoAttribute?
		let predicate = NSPredicate(format: "todoId == %@", argumentArray: [todo.id])
		spreadSheetTodoAttributeRepository.find(predicate: predicate) { result in
			switch result {
				case .success(let attributes):
					guard let foundAttribute = attributes.first else {
						fatalError("sheetAttribute not found")
					}
					attribute = foundAttribute
				default:
					fatalError("sheetAttribute not found")
			}
		}
		
		guard let validAttribute = attribute else {
			print("attribute not found")
			return
		}
		
		let preset: Preset? = sheetPresetRepository.findByPrimaryKey(validAttribute.presetId)

		guard let validPreset = preset else {
			print("preset not found")
			return
		}
		
		let doneOrNot = todo.status!.finished ? "DONE" : ""
		let text = todo.status!.detail != "" ? todo.status!.detail : doneOrNot
		let query = UpdateSpreadSheetCellQuery(
			spreadsheetId: validPreset.spreadSheetId,
			tabName: validPreset.tabName,
			targetRow: validPreset.targetRow,
			targetColumn: validAttribute.column,
			text: text
		)
		
		GoogleAPIClient.shared.updateSpreadSheetCell(query)
	}
}
