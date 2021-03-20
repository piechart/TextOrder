//
//  AppDelegate.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		self.setupWindow()
		
		return true
	}

	private func setupWindow() {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = TextOrderViewController()
		self.window?.makeKeyAndVisible()
	}
}

