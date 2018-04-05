//
//  CakeDetailViewController.swift
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

class CakeDetailViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	
	@IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
	
	var cakeInfo: CakeInfo? {
		didSet {
			if let info = cakeInfo {
				if let image = info.actualImage {
					self.imageView.image = image
				} else if let url = URL(string: info.image) {
					ImageCache.getImage(at: url) { [unowned self] (image, error) in
						self.imageView.image = image
					}
				}
				if isViewLoaded {
					titleLabel.text = info.title
					detailLabel.text = info.desc
				}
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let swipeGester = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
		swipeGester.direction = .down
		view.addGestureRecognizer(swipeGester)
    }
	
	func handleSwipe(_ sender: UISwipeGestureRecognizer) {
		UIView.animate(withDuration: 0.25, animations: {
			self.view.frame.origin.y = self.parent!.view.frame.maxY
		}) { (finished) in
			self.view.removeFromSuperview()
			self.removeFromParentViewController()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
