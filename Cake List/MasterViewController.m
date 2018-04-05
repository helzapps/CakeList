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
#import "UIView+Extension.h"

@interface MasterViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_imageDownloadsInProgress = [NSMutableDictionary dictionary];
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
	if (cakeInfo.actualImage == nil && self.tableView.isDragging == NO && self.tableView.decelerating == false) {
		[self startIconDownload:cakeInfo forIndexPath:indexPath];
	} else {
		[cell setCakeImage:cakeInfo.actualImage];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	CakeInfo *cakeInfo = [[[CakeDataManager shared] cakes] objectAtIndex:indexPath.row];
	CakeDetailViewController *detailVC = (CakeDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"cake detail"];
	detailVC.view.translatesAutoresizingMaskIntoConstraints = NO;
	[self.navigationController addChildViewController:detailVC];
	[self.navigationController.view addSubview:detailVC.view];
	[detailVC.view constrainToSuperView];
	detailVC.cakeInfo = cakeInfo;
	detailVC.view.frame = ({
		CGRect newFrame = detailVC.view.frame;
		newFrame.origin.y = self.view.frame.size.height;
		newFrame;
	});
	[UIView animateWithDuration:0.25 animations:^{
		detailVC.view.frame = ({
			CGRect newFrame = detailVC.view.frame;
			newFrame.origin.y = 0;
			newFrame;
		});
	}];
}

- (void)startIconDownload:(CakeInfo *)cakeInfo forIndexPath:(NSIndexPath *)indexPath {
	CakeInfo *requestedCakeInfo = (self.imageDownloadsInProgress)[indexPath];
	if (requestedCakeInfo == nil) {
		[ImageCache getImageAt:[NSURL URLWithString:[cakeInfo image]] completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
			CakeCell *cell = (CakeCell *)[self.tableView cellForRowAtIndexPath:indexPath];
			[cell setCakeImage:cakeInfo.actualImage];
			[self.imageDownloadsInProgress removeObjectForKey:indexPath];
		}];
		(self.imageDownloadsInProgress)[indexPath] = cakeInfo;
	}
}

- (void)loadImagesForOnscreenRows {
	if ([[CakeDataManager shared] cakes] > 0) {
		NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
		for (NSIndexPath *indexPath in visiblePaths) {
			CakeInfo *cakeInfo = [[[CakeDataManager shared] cakes] objectAtIndex:indexPath.row];
			
			if (!cakeInfo.actualImage) {
				[self startIconDownload:cakeInfo forIndexPath:indexPath];
			}
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate) {
		[self loadImagesForOnscreenRows];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self loadImagesForOnscreenRows];
}

@end
