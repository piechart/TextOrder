//
//  BaseViewController.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

class BaseViewController<RootViewClass: UIView, ViewModelClass: ViewModel>: UIViewController, RootViewType {
	typealias RootViewType = RootViewClass
	
	var viewModel: ViewModelClass!
	
	override func loadView() {
		self.view = RootViewClass()
	}
	
	func setupViewModel() {
		fatalError("Must be overriden")
	}
	
	override func viewDidLoad() {
		self.setupViewModel()
		
		super.viewDidLoad()
	}
}

