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
@property (nonatomic, retain) UILabel     *venueDetailLabel;
@property (nonatomic, retain) UILabel     *startDateLabel;
@property (nonatomic, retain) UITableView *videoTableView;
@property (nonatomic, retain) GOGig       *gigEvent;

- (void)retrieveGigVideos;
- (void)onCreate:(id)sender;

@end

@implementation GODetailViewController

@synthesize artistImage;
@synthesize venueDetailLabel;
@synthesize videoTableView;
@synthesize startDateLabel;
@synthesize gigEvent;

- (void)dealloc
{
    self.gigEvent         = nil;
    self.artistImage      = nil;
    self.startDateLabel   = nil;
    self.venueDetailLabel = nil;
    self.videoTableView   = nil;
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
    artistImage.contentMode = UIViewContentModeScaleToFill;
    artistImage.autoresizesSubviews = NO;
    artistImage.urlStr = gigEvent.artistImgUrl;
    [self.view addSubview:artistImage];
    
    UIImage *image = [UIImage imageNamed:@"TopbarButton.png"];
    UIImage* plusIcon = [UIImage imageNamed:@"ICO-PlusTop.png"];
    
    UIImageView *bubbleImage = [[UIImageView alloc] initWithFrame:CGRectMake(30., 165., 240., 100.)];
    bubbleImage.image = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:14. topCapHeight:30.];
    [self.view addSubview:bubbleImage];
    
    self.venueDetailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40., 183., 240, 41.)] autorelease];
    venueDetailLabel.numberOfLines = 2;
    venueDetailLabel.backgroundColor = [UIColor clearColor];
    venueDetailLabel.text = gigEvent.venueName;
    [self.view addSubview:venueDetailLabel];
    
    self.startDateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40., 213., 240, 41.)] autorelease];
    startDateLabel.numberOfLines = 1;
    startDateLabel.backgroundColor = [UIColor clearColor];
    startDateLabel.text = gigEvent.startDate;
    [self.view addSubview:startDateLabel];
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setBackgroundImage:image forState:UIControlStateNormal];
    [refreshButton setImage:plusIcon forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(onCreate:) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.frame = CGRectMake(214, 183, plusIcon.size.width + 20, image.size.height);
    [self.view addSubview:refreshButton];
    
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
    NSString *videoUrl = [(GOGigVideoInfo *)[gigEvent.videoArray objectAtIndex:indexPath.row] videoStringUrl];
    NSString *descriptionString = [(GOGigVideoInfo *)[gigEvent.videoArray objectAtIndex:indexPath.row] videoDescription];
    
    static NSString *CellIdentifier = @"Cell";
    GOGigDetailTableViewCell *cell = (GOGigDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {        
        cell = [[[GOGigDetailTableViewCell alloc] initWithUrlString:videoUrl
                                                 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.videoLabel.text = descriptionString;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UtilsFunct
- (void)retrieveGigVideos{
    
    GOFetchVideoOperation *fetchVideoData = [[GOFetchVideoOperation alloc] initWithArtistName:[gigEvent artistName]];
    [fetchVideoData setDelegate:self]; 
    [fetchVideoData retrieveVideoData];
}

- (void)onCreate:(id)sender{

    
}

#pragma mark -
#pragma mark Delegate implementation
- (void)fetchVideoRequestDidFinishWithArray:(NSArray *)gigsVideoArray
{
    [gigEvent setVideoArray:gigsVideoArray];
    [videoTableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
	
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
