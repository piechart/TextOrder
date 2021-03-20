//
//  TilesBarViewModel.swift
//  TextOrder
//
//  Created by apples on 20.03.2021.
//

import Foundation

protocol TilesBarViewModel {
	var tilesViewModels: [TileViewModel] { get set }
	
	func remove(viewModel: TileViewModel)
	func insert(viewModel: TileViewModel) -> Int?
	
	func update(viewModel: TileViewModel) -> Int?
	func update(oldViewModel: TileViewModel, newViewModel: TileViewModel)
	func update(at index: Int, viewModel: TileViewModel)
}

final class TilesBarViewModelImpl: TilesBarViewModel {
	var tilesViewModels: [TileViewModel]
	
	private let cachedTiles: [TileViewModel]
	
	init(tilesViewModels: [TileViewModel]) {
		self.tilesViewModels = tilesViewModels
		self.cachedTiles = tilesViewModels
	}
	
	func remove(viewModel: TileViewModel) {
		self.tilesViewModels.removeAll(where: { $0.value == viewModel.value })
	}
	
	func update(at index: Int, viewModel: TileViewModel) {
		self.tilesViewModels[index] = viewModel
	}
	
	func update(oldViewModel: TileViewModel, newViewModel: TileViewModel) {
		if let index = self.tilesViewModels.firstIndex(where: { $0.value.lowercased() == oldViewModel.value.lowercased() }) {
			self.tilesViewModels[index] = newViewModel
		}
	}
	
	func update(viewModel: TileViewModel) -> Int? {
		if let index = self.tilesViewModels.firstIndex(where: { $0.value.isEmpty }) {
			self.tilesViewModels[index] = viewModel
			return index
		}
		return nil
	}
	
	func insert(viewModel: TileViewModel) -> Int? {
		if let originalIndex = self.cachedTiles.firstIndex(where: { $0.value == viewModel.value }),
		   originalIndex < self.tilesViewModels.count {
			self.tilesViewModels.insert(viewModel, at: originalIndex)
			return originalIndex
			
		} else {
			self.tilesViewModels.append(viewModel)
			return nil
		}
	}
}
