//
//  TileViewModel.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import Foundation

protocol TileViewModel {
	var value: String { get }
	
	var isEmpty: Bool { get }
}

final class TileViewModelImpl: TileViewModel {
	let value: String
	
	var isEmpty: Bool {
		self.value.isEmpty
	}
	
	init(value: String) {
		self.value = value
	}
}
