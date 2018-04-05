//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "Cake_List-Swift.h"

@interface MasterViewController ()
//@property (strong, nonatomic) NSArray <CakeInfo *> *cakeInfoObjects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[CakeDataManager refresh:^{
		[self.tableView reloadData];
	}];
	
//	[self performSelectorInBackground:@selector(getData) withObject:nil];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[CakeDataManager shared] cakes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
	
	CakeInfo *cakeInfo = [[[CakeDataManager shared] cakes] objectAtIndex:indexPath.row];
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

@end
