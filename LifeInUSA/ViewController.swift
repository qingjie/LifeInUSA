//
//  ViewController.swift
//  LifeInUS
//
//  Created by Qingjie Zhao on 6/19/16.
//  Copyright © 2016 Qingjie Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
	
	
	var scrollView: UIScrollView!
	var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem?.title = NSLocalizedString("ABOUT", comment: "About")
		
		imageView = UIImageView(image: UIImage(named: "image.jpg"))
		
		scrollView = UIScrollView(frame: view.bounds)
		scrollView.backgroundColor = UIColor.blackColor()
		scrollView.contentSize = imageView.bounds.size
		scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		scrollView.contentOffset = CGPoint(x: 1000, y: 450)
		
		scrollView.frame = CGRectMake(0, 64, 600, 546)
		
		scrollView.addSubview(imageView)
		
		view.addSubview(scrollView)
		scrollView.delegate = self
		
		setZoomScale()
		
		setupGestureRecognizer()
	}
	
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
	override func viewWillLayoutSubviews() {
		setZoomScale()
	}
	
	func scrollViewDidZoom(scrollView: UIScrollView) {
		let imageViewSize = imageView.frame.size
		let scrollViewSize = scrollView.bounds.size
		
		let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
		let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
		
		scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
	}
	
	func setZoomScale() {
		let imageViewSize = imageView.bounds.size
		let scrollViewSize = scrollView.bounds.size
		let widthScale = scrollViewSize.width / imageViewSize.width
		let heightScale = scrollViewSize.height / imageViewSize.height
		
		scrollView.minimumZoomScale = min(widthScale, heightScale)
		scrollView.zoomScale = 1.0
	}
	
	func setupGestureRecognizer() {
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleDoubleTap(_:)))
		doubleTap.numberOfTapsRequired = 2
		scrollView.addGestureRecognizer(doubleTap)
	}
	
	func handleDoubleTap(recognizer: UITapGestureRecognizer) {
		
		if (scrollView.zoomScale > scrollView.minimumZoomScale) {
			scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
		} else {
			scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
		}
	}
	


	
}

