//
//  ImageCache.swift
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

class ImageCache: NSObject {
	
	static let shared = ImageCache()
	private var cache: [String : CacheObject] = [:]
	
	class func getImage(at url: URL, completionHandler: @escaping CacheObject.CompletionBlock) {
		if let cacheObject = shared.cache[url.absoluteString] {
			if let image = cacheObject.image {
				return completionHandler(image, nil)
			}
			cacheObject.completionBlocks.append(completionHandler)
		} else {
			let cacheObject = CacheObject()
			cacheObject.completionBlocks.append(completionHandler)
			shared.cache[url.absoluteString] = cacheObject
			shared.downloadImage(at: url) { (image: UIImage?, error: Error?) in
				guard let cacheObject = ImageCache.shared.cache[url.absoluteString] else {
					return
				}
				cacheObject.image = image
				for block in cacheObject.completionBlocks {
					block(image, error)
				}
				cacheObject.completionBlocks.removeAll()
			}
		}
	}
	
	class func getImage(at urlString: String) -> UIImage? {
		var image: UIImage?
		if let cacheObject = shared.cache[urlString] {
			image = cacheObject.image
		}
		return image
	}
	
	private func downloadImage(at url: URL, completionHandler: @escaping CacheObject.CompletionBlock) {
		DispatchQueue.global(qos: .background).async {
			var image: UIImage?
			var anError: Error?
			defer {
				DispatchQueue.main.async {
					completionHandler(image, anError)
				}
			}
			do {
				let imageData = try Data.init(contentsOf: url)
				image = UIImage(data: imageData)
			} catch {
				anError = error
			}
		}
	}
	
}

class CacheObject: NSObject {
	typealias CompletionBlock = (_ image: UIImage?,_ error: Error?)->Void
	
	var image: UIImage?
	var completionBlocks: [CompletionBlock] = []
}
