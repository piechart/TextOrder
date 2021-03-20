//
//  TextOrderViewModel.swift
//  TextOrder
//
//  Created by apples on 20.03.2021.
//

import Foundation

protocol TextOrderViewModel: ViewModel {
	var phrase: String { get }
	var isOrderValid: Bool { get }
	
	var targetTilesViewModel: TilesBarViewModel { get set }
	var userTilesViewModel: TilesBarViewModel { get set }
	
	func makeEmptyTileViewModel() -> TileViewModel
}

final class TextOrderViewModelImpl: TextOrderViewModel {
	let phrase: String
	
	var isOrderValid: Bool {
		let userTiles = self.userTilesViewModel.tilesViewModels.map { $0.value.lowercased() }
		let targetTiles = self.validWordsOrder.map { $0.lowercased() }
		return userTiles == targetTiles
	}
	
	lazy var targetTilesViewModel: TilesBarViewModel = {
		let targetViewModels = self.validWordsOrder.reversed().map { TileViewModelImpl(value: $0) }
		return TilesBarViewModelImpl(tilesViewModels: targetViewModels)
	}()
	
	lazy var userTilesViewModel: TilesBarViewModel = {
		let emptyViewModels = Array(repeating: self.makeEmptyTileViewModel(), count: self.validWordsOrder.count)
		return TilesBarViewModelImpl(tilesViewModels: emptyViewModels)
	}()
	
	private lazy var validWordsOrder: [String] = {
		self.phrase.words.map { $0.uppercased() }
	}()
	
	init(phrase: String) {
		self.phrase = phrase
	}
	
	func makeEmptyTileViewModel() -> TileViewModel {
		TileViewModelImpl(value: "")
	}
}
