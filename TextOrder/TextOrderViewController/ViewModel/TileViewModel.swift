//
//  TileViewModel.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import Foundation

protocol TileViewModel {
	var value: String { get }
}

final class TileViewModelImpl: TileViewModel {
	let value: String
	
	init(value: String) {
		self.value = value
	}
}
