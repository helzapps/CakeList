//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@implementation CakeCell

- (void)prepareForReuse {
	[super prepareForReuse];
	[self setCakeImage:nil];
}

- (void)setCakeImage:(UIImage *)image {
	self.cakeImageView.backgroundColor = [UIColor clearColor];
	if (!image) {
		self.cakeImageView.backgroundColor = [UIColor lightGrayColor];
	}
	self.cakeImageView.image = image;
}

@end
