//
//  SpreadSheetFromView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import SwiftUI

struct SpreadSheetFormView: View {
	@Binding var spreadSheetPreset: SpreadSheetPreset
	var spreadSheetList: [SpreadSheetFile]
	var sheetList: [SheetProperties]
	let fetchSpreadSheetInfo: (() -> Void)
	let	fetchSpreadSheetCells: (() -> Void)
    var body: some View {
		Form {
			Section(header: Text("プリセット名"), footer: Text("セクション名になります")) {
				TextField("プリセット名", text: $spreadSheetPreset.title)
			}
			Section(header: Text("スプレッドシート名")) {
				Picker("Spread Sheet Id", selection: $spreadSheetPreset.spreadSheetId) {
					ForEach(spreadSheetList, id: \.id) { file in
						Text(file.name)
					}
				}
				.onChange(of: spreadSheetPreset.spreadSheetId) { _ in
					fetchSpreadSheetInfo()
				}
				
			}
			Section(header: Text("シート名")) {
				Picker("Spread Sheet Id", selection: $spreadSheetPreset.tabName) {
					ForEach(sheetList, id: \.title) { sheet in
						Text(sheet.title)
					}
				}
			}
			Section(header: Text("行"), footer: Text("半角数字でよろ")) {
				TextField("行", text: $spreadSheetPreset.row)
			}
			Section(header: Text("列")) {
				// NOTE: A~Cなど
				Picker("Spread Sheet Column", selection: $spreadSheetPreset.column.start) {
					ForEach(SheetColumnEnum.allCases, id: \.self) { column in
						Text(column.rawValue)
					}
				}
				Picker("Spread Sheet Column", selection: $spreadSheetPreset.column.end) {
					ForEach(SheetColumnEnum.allCases, id: \.self) { column in
						Text(column.rawValue)
					}
				}
			}
		}
    }
}

struct SpreadSheetFromView_Previews: PreviewProvider {
	@State static var spreadSheetPreset = SpreadSheetPreset()
	static func test() {
		
	}
    static var previews: some View {
		NavigationView {
			SpreadSheetFormView(
				spreadSheetPreset: $spreadSheetPreset,
				spreadSheetList: [],
				sheetList: [],
				fetchSpreadSheetInfo: test,
				fetchSpreadSheetCells: test
			)
		}
    }
}
