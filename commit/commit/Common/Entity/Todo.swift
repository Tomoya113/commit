//
//  Todo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class DisplayTag: EmbeddedObject {
	@objc dynamic var tagId: String = ""
	
	convenience init(tagId: String) {
		self.init()
		self.tagId = tagId
	}
}

class TodoStatus: EmbeddedObject {
	@objc dynamic var finished: Bool = false
	@objc dynamic var detail: String = ""
	
	convenience init(finished: Bool, detail: String) {
		self.init()
		self.finished = finished
		self.detail = detail
	}
}

class Todo: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var title: String = ""
	@objc dynamic var subtitle: String = ""
	@objc dynamic var status: TodoStatus?
	let tags = List<DisplayTag>()
	@objc dynamic var todoType: String = TodoType.undefined.rawValue
	
	var type: TodoType {
		get { return TodoType(rawValue: todoType) ?? .undefined }
		set { todoType = newValue.rawValue }
	}
	
	convenience init(title: String, detail: String = "", displayTag: [DisplayTag], todoType: TodoType) {
		self.init()
		self.title = title
		self.subtitle = detail
		self.status = TodoStatus(finished: false, detail: "")
		self.type = todoType
		tags.append(objectsIn: displayTag)
	}
	override static func primaryKey() -> String? {
		return "id"
	}

}

enum TodoType: String {
	case normal
	case googleSheets
	case undefined
}
