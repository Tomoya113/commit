//
//  SheetsFilesFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class SheetsFilesFetchInteractor: UseCase {
	let repository: OldGoogleAPIClientProtocol
	
	init(repository: OldGoogleAPIClientProtocol = OldGoogleAPIClient.shared) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<[SheetsFile], Error>) -> Void )?) {
		repository.fetchSheetsFiles(contains: parameters) { result in
			switch result {
				case .success(let files):
					completion?(.success(files))
				case .failure(let error):
					completion?(.failure(error))
			}
		}
	}

}
