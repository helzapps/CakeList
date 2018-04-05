//
//  UIView+Extension.m
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)constrainToSuperView
{
	NSArray *attributes = @[@(NSLayoutAttributeLeading), @(NSLayoutAttributeTrailing), @(NSLayoutAttributeTop), @(NSLayoutAttributeBottom)];
	for (NSNumber *attribute in attributes) {
		[[NSLayoutConstraint constraintWithItem:self
									  attribute:attribute.integerValue
									  relatedBy:NSLayoutRelationEqual
										 toItem:self.superview
									  attribute:attribute.integerValue
									 multiplier:1.0
									   constant:0.0] setActive:YES];
	}
}

@end
