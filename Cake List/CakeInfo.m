//
//  CakeInfo.m
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "CakeInfo.h"

static NSString * const descKey = @"desc";
static NSString * const imageKey = @"image";
static NSString * const titleKey = @"title";

@implementation CakeInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		NSArray *propKeys = @[@"desc", @"title", @"imageURLString"];
		NSArray *dictKeys = @[descKey, titleKey, imageKey];
		for (NSInteger index = 0; index < propKeys.count; index++) {
			NSString *dictionaryKey = dictKeys[index];
			NSString *propertyKey = propKeys[index];
			if (dictionary[dictionaryKey]) {
				[self setValue:dictionary[dictionaryKey] forKey:propertyKey];
			}
		}
	}
	return self;
}

@end
