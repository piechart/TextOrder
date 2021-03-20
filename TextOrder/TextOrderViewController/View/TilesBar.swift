//
//  TilesBar.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

final class TilesBar: UIView {
	
	var tiles: [TileView] {
		self.stackView.arrangedSubviews.compactMap { $0 as? TileView }
	}
	
	var isFilled: Bool {
		self.tiles.allSatisfy({ !$0.viewModel.isEmpty })
	}
	
	var tileWidth: CGFloat {
		self.tiles.first?.frame.width ?? 0
	}
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.spacing = 6
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.alignment = .fill
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	func setupTiles(viewModel: TilesBarViewModel) {
		self.stackView.arrangedSubviews.forEach {
			self.stackView.removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
		
		viewModel.tilesViewModels.forEach {
			self.insert(viewModel: $0, index: nil)
		}
	}
	
	func remove(tile: TileView) {
		self.stackView.removeArrangedSubview(tile)
		tile.removeFromSuperview()
	}
	
	func updateAvailable(index: Int, with viewModel: TileViewModel) {
		self.tiles[index].viewModel = viewModel
	}
	
	func updateIntersecting(by view: UIView, with viewModel: TileViewModel) -> Int? {
		let tile: TileView? = self.tiles
			.filter { $0.viewModel.isEmpty }
			.map { ($0, self.convert($0.frame, to: nil).intersectionPercentage(view.frame)) }
			.filter { $0.1 > 0.3 } // must intersect for at least 30% by its frame to be counted
			.sorted(by: { $0.1 < $1.1 })
			.last?.0
		
		tile?.viewModel = viewModel
		
		if let tile = tile, let index = self.tiles.firstIndex(of: tile) {
			return index
		}
		
		return nil
	}
	
	@discardableResult
	func insert(viewModel: TileViewModel, index: Int?) -> TileView {
		let tileView = TileView()
		tileView.viewModel = viewModel
		
		if let originalIndex = index {
			self.stackView.insertArrangedSubview(tileView, at: originalIndex)
			
		} else {
			self.stackView.addArrangedSubview(tileView)
		}
		return tileView
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	private func commonInit() {
		self.addSubview(self.stackView)
		self.stackView.pinEdges(to: self)
	}
}
