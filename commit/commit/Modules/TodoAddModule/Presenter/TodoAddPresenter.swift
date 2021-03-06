//
//  TodoAddPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

class TodoAddPresenter: ObservableObject {
	
	@Published var currentTodoType: TodoTypes = .normal
	@Published var currentTodoTypeIndex: Int = 0
	@Published var currentList: ListRealm?
	@Published var currentSection: [SectionRealm] = []
	
	struct Dependency {
		var currentListFetchInteractor: AnyUseCase<String, ListRealm, Error>
	}
	
	private let dependency: Dependency
	private let router = TodoAddRouter()
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func normalTodoAddLinkBuilder() -> some View {
		router.generateNormalTodoAddView()
	}
	
	func sheetsTodoAddLinkBuilder() -> some View {
		router.generateSheetsTodoAddView()
	}
	
	func onAppear() {
		if currentSection.isEmpty {
			fetchCurrentList()
		}
	}
	
	func fetchCurrentList() {
		dependency.currentListFetchInteractor.execute("") { result in
			switch result {
				case .success(let list):
					self.currentList = list
					self.currentSection = Array(list.sections)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
}

#if DEBUG
extension TodoAddPresenter {
	static let currentListFetchInteractor = CurrentListFetchInteractor()
	static let dependency = TodoAddPresenter.Dependency(currentListFetchInteractor: AnyUseCase(currentListFetchInteractor))
	static let sample: TodoAddPresenter = {
		return TodoAddPresenter(dependency: dependency)
	}()
}

#endif
