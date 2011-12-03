//
//  GODetailViewController.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GODetailViewController.h"
#import "GOGigDetailTableViewCell.h"
#import "GOGigVideoInfo.h"
#import "GOGig.h"
#import "GOAppDelegate.h"
#import "PSLog.h"

@interface GODetailViewController ()

@property (nonatomic, retain) ULImageView *artistImage;
@property (nonatomic, retain) UILabel     *detailDescriptionLabel;
@property (nonatomic, retain) UITableView *videoTableView;
@property (nonatomic, retain) GOGig       *gigEvent;

- (void)retrieveGigVideos;

@end

@implementation GODetailViewController

@synthesize artistImage;
@synthesize detailDescriptionLabel;
@synthesize videoTableView;
@synthesize gigEvent;

- (void)dealloc
{
    self.gigEvent = nil;
    self.artistImage = nil;
    self.detailDescriptionLabel = nil;
    self.videoTableView = nil;
}

- (id)initWithGOGig:(GOGig *)_gigEvent
{
    self = [self init];
    if (self) {
        
        self.gigEvent = [[[GOGig alloc] init] autorelease];
        gigEvent = _gigEvent;
        
        self.title = gigEvent.artistName;

    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.artistImage = [[[ULImageView alloc] initWithFrame:CGRectMake(49., 20., 222., 140.)] autorelease];
    artistImage.contentMode = UIViewContentModeScaleAspectFit;
    artistImage.urlStr = gigEvent.artistImgUrl;
    [self.view addSubview:artistImage];
    
    self.detailDescriptionLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40., 173., 240, 81.)] autorelease];
    detailDescriptionLabel.numberOfLines = 4;
    detailDescriptionLabel.text = @"Bloody hell retrieve this info somewhere";
    [self.view addSubview:detailDescriptionLabel];
    
    self.videoTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0, 262., 320., 162.) style:UITableViewStyleGrouped] autorelease];
    videoTableView.delegate = self;
    videoTableView.dataSource = self;
    videoTableView.backgroundColor = [UIColor clearColor];
    videoTableView.rowHeight = 75.0;
    [self.view addSubview:videoTableView]; 
    
    [self retrieveGigVideos];
}

#pragma mark
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (gigEvent.videoArray) {
        return [gigEvent.videoArray count];
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    GOGigDetailTableViewCell *cell = (GOGigDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSString *videoUrl = [(GOGigVideoInfo *)[gigEvent.videoArray objectAtIndex:indexPath.row] videoStringUrl];
        NSString *descriptionString = [(GOGigVideoInfo *)[gigEvent.videoArray objectAtIndex:indexPath.row] videoDescription];
        
        cell = [[[GOGigDetailTableViewCell alloc] initWithUrlString:videoUrl
                                                 reuseIdentifier:CellIdentifier] autorelease];
        cell.videoLabel.text = descriptionString;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UtilsFunct
- (void)retrieveGigVideos{
    
    // Parse here the gigEvent.videoArray obJect and then reload the tableView
    
    [self.videoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
							
@end
