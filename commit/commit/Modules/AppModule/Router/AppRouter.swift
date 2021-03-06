//
//  AppRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import Foundation
import SwiftUI

class AppRouter {
	func generateTodoListView() -> some View {
		let presenter: TodoListPresenter = {
			let listFetchInteractor = AnyUseCase(ListFetchInteractor())
			let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor())
			let deleteSectionInteractor = AnyUseCase(DeleteSectionInteractor())
			let dependency = TodoListPresenter.Dependency(
				listFetchInteractor: listFetchInteractor,
				todoUpdateInteractor: todoUpdateInteractor,
				deleteSectionInteractor: deleteSectionInteractor, wireframe: TodoListRouter()
			)
			return TodoListPresenter(dependency: dependency)
		}()
		return (
			TodoListView(presenter: presenter)
		)
	}
	
	func generateSettingsView() -> some View {
		let presenter: SettingsPresenter = SettingsPresenter()
		return (
			SettingsView(presenter: presenter)
		)
	}
}
