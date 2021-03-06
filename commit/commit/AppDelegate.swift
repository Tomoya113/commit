//
//  AppDelegate.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/14.
//

import UIKit
import RealmSwift
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// NOTE: これちゃんと理解して書いたほうが良さそう
		let config = Realm.Configuration(
			schemaVersion: 1,
			migrationBlock: nil,
			// DANGER: これ絶対にやばいわ
			deleteRealmIfMigrationNeeded: true
		)
		Realm.Configuration.defaultConfiguration = config
//		#if DEBUG
//			DataEraser.execute()
//		#endif
		print(Realm.Configuration.defaultConfiguration.fileURL!)
		let IS_FIRST_VISIT: String = "isFirstVisit"
		if UserDefaults.standard.object(forKey: IS_FIRST_VISIT) == nil {
			UserDataInitializer.generateInitialUserData()
			UserDefaults.standard.set(true, forKey: IS_FIRST_VISIT)
		}
		GIDSignIn.sharedInstance().delegate = GoogleOAuthManager.shared
		GoogleOAuthManager.signIn()
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url)
	}
	
	// MARK: UISceneSession Lifecycle

	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running,
		// this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
}
