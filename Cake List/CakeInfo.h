//
//  CakeInfo.h
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CakeInfo : NSObject

@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *imageURLString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
