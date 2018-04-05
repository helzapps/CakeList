//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "CakeInfo.h"

@interface MasterViewController ()
@property (strong, nonatomic) NSArray <CakeInfo *> *cakeInfoObjects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self performSelectorInBackground:@selector(getData) withObject:nil];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakeInfoObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
	
	CakeInfo *cakeInfo = self.cakeInfoObjects[indexPath.row];
	cell.titleLabel.text = cakeInfo.title;
	cell.descriptionLabel.text = cakeInfo.desc;

    
//    NSURL *aURL = [NSURL URLWithString:object[@"image"]];
//    NSData *data = [NSData dataWithContentsOfURL:aURL];
//    UIImage *image = [UIImage imageWithData:data];
//    [cell.cakeImageView setImage:image];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getData{
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:kNilOptions
                       error:&jsonError];
    if (!jsonError){
		if ([responseData isKindOfClass:[NSArray class]]) {
			NSArray *responseObjects = (NSArray *)responseData;
			NSMutableArray *tempCakeInfo = [NSMutableArray<CakeInfo *> arrayWithCapacity:responseObjects.count];
			for (id object in responseObjects) {
				if ([object isKindOfClass:[NSDictionary class]]) {
					NSDictionary *cakeDictionary = (NSDictionary *)object;
					[tempCakeInfo addObject:[[CakeInfo alloc] initWithDictionary:cakeDictionary]];
				}
			}
			self.cakeInfoObjects = [NSArray <CakeInfo *> arrayWithArray:tempCakeInfo];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.tableView reloadData];
			});
		}
    } else {
		
    }
    
}

@end
