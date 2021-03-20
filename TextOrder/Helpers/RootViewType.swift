//
//  RootViewType.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

public protocol RootViewType {
	associatedtype RootViewType: UIView
}

public extension RootViewType where Self: UIViewController {
	var rootView: RootViewType {
		self.view as! RootViewType
	}
}

