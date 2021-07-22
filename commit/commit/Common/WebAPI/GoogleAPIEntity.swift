//
//  GoogleAPIEntity.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/20.
//
import Foundation

struct UpdateSpreadSheetCellQuery {
	let spreadsheetId: String
	let tabName: String
	let targetRow: String
	let targetColumn: String
	let text: String
}

struct QueryColumn {
	let start: String
	let end: String
}

struct FetchSheetCellsQuery {
	let sheetName: String
	let spreadSheetId: String
	let column: QueryColumn
	let row: String
}

struct FetchSheetsCellQuery {
	let sheetName: String
	let spreadSheetId: String
	let column: String
	let row: String
}
