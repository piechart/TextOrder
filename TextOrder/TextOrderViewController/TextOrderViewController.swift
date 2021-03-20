//
//  TextOrderViewController.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

final class TextOrderViewController: BaseViewController<TextOrderRootView, TextOrderViewModelImpl> {

	override func setupViewModel() {
		self.viewModel = TextOrderViewModelImpl(phrase: "It's me, Mario!")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.rootView.progressView.progress = 0.6
		self.rootView.headerLabel.text = "Put words in correct order."
		self.rootView.phraseLabel.text = self.viewModel.phrase
		self.rootView.targetTilesBar.setupTiles(viewModel: self.viewModel.targetTilesViewModel)
		self.rootView.userTilesbar.setupTiles(viewModel: self.viewModel.userTilesViewModel)
		self.rootView.checkButton.setTitle("CHECK", for: .normal)
		
		self.rootView.targetTilesBar.tiles.forEach {
			self.addTargetTileTapGesture(tileView: $0)
		}
		
		self.rootView.userTilesbar.tiles.forEach {
			let tap = UITapGestureRecognizer(target: self, action: #selector(self.userTileTapped(tap:)))
			$0.addGestureRecognizer(tap)
		}
		
		self.rootView.checkButton.addTarget(self, action: #selector(self.checkTapped), for: .touchUpInside)
	}
	
	private func addTargetTileTapGesture(tileView: TileView) {
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.targetTileTapped(tap:)))
		tileView.addGestureRecognizer(tap)
		
		let pan = UIPanGestureRecognizer(target: self, action: #selector(self.targetTilePanned(pan:)))
		tileView.addGestureRecognizer(pan)
	}
}

// MARK: - Actions
@objc
private extension TextOrderViewController {
	func targetTileTapped(tap: UITapGestureRecognizer) {
		guard let tileView = tap.view as? TileView else {
			return
		}
		self.viewModel.targetTilesViewModel.remove(viewModel: tileView.viewModel)
		self.rootView.targetTilesBar.remove(tile: tileView)
		
		if let index = self.viewModel.userTilesViewModel.update(viewModel: tileView.viewModel) {
			self.rootView.userTilesbar.updateAvailable(index: index, with: tileView.viewModel)
		}
		
		self.rootView.checkButton.isEnabled = self.rootView.userTilesbar.isFilled
	}
	
	func userTileTapped(tap: UITapGestureRecognizer) {
		guard let tileView = tap.view as? TileView, !tileView.viewModel.value.isEmpty else {
			return
		}
		
		let index = self.viewModel.targetTilesViewModel.insert(viewModel: tileView.viewModel)
		let newTileView = self.rootView.targetTilesBar.insert(viewModel: tileView.viewModel, index: index)
		self.addTargetTileTapGesture(tileView: newTileView)
		
		let newViewModel = self.viewModel.makeEmptyTileViewModel()
		self.viewModel.userTilesViewModel.update(oldViewModel: tileView.viewModel, newViewModel: newViewModel)
		tileView.viewModel = newViewModel
		
		self.rootView.checkButton.isEnabled = self.rootView.userTilesbar.isFilled
	}
	
	func targetTilePanned(pan: UIPanGestureRecognizer) {
		guard let originTileView = pan.view as? TileView, !originTileView.viewModel.value.isEmpty else {
			return
		}
		if pan.state == .began {
			let tileCopy = TileView()
			tileCopy.viewModel = originTileView.viewModel
			self.rootView.addSubview(tileCopy)
			let convertedFrame = self.rootView.targetTilesBar.convert(originTileView.frame, to: self.rootView)
			tileCopy.frame = CGRect(
				origin: convertedFrame.origin,
				size: CGSize(width: self.rootView.userTilesbar.tileWidth, height: originTileView.bounds.height)
			)
			tileCopy.center = CGPoint(x: convertedFrame.midX, y: convertedFrame.midY)
			self.rootView.panningTile = tileCopy
			
		} else if pan.state == .changed {
			self.rootView.panningTile?.center = pan.location(in: self.rootView)
			
		} else if pan.state == .ended {
			if self.rootView.panningTile?.frame.intersects(self.rootView.userTilesbar.frame) == true {
				let originViewModel = originTileView.viewModel!
				if let originIndex = self.rootView.userTilesbar.updateIntersecting(by: self.rootView.panningTile!, with: originViewModel) {
					self.viewModel.targetTilesViewModel.remove(viewModel: originViewModel)
					self.rootView.targetTilesBar.remove(tile: originTileView)
					
					self.viewModel.userTilesViewModel.update(at: originIndex, viewModel: originViewModel)
				}
			}
			self.rootView.panningTile?.removeFromSuperview()
			self.rootView.panningTile = nil
			
			self.rootView.checkButton.isEnabled = self.rootView.userTilesbar.isFilled
		}
	}
	
	func checkTapped() {
		let alert = UIAlertController(title: self.viewModel.isOrderValid ? "✅ Correct" : "❌ Incorrect", message: nil, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
