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
#import "GOFetch4SqVenueId.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "SFHFKeychainUtils.h"

@interface GODetailViewController ()

@property (nonatomic, retain) ULImageView *artistImage;
@property (nonatomic, retain) UILabel     *venueDetailLabel;
@property (nonatomic, retain) UILabel     *startDateLabel;
@property (nonatomic, retain) UITableView *videoTableView;
@property (nonatomic, retain) GOGig       *gigEvent;

- (void)retrieveGigVideos;
- (void)onCreate:(id)sender;
- (void)showMore;
- (void)postHangoutEventWithId:(NSString *)hangoutId;

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
    
    self.artistImage = [[[ULImageView alloc] initWithFrame:CGRectMake(85., 20., 130., 140.)] autorelease];
    artistImage.contentMode = UIViewContentModeScaleToFill;
    artistImage.autoresizesSubviews = YES;
    artistImage.urlStr = gigEvent.artistLargeImgUrl;
    [self.view addSubview:artistImage];
    
    UIImage *image = [UIImage imageNamed:@"TopbarButton.png"];
    UIImage* plusIcon = [UIImage imageNamed:@"ICO-PlusTop.png"];
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setBackgroundImage:image forState:UIControlStateNormal];
    [refreshButton setImage:plusIcon forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(onCreate:) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.frame = CGRectMake(0, 0, plusIcon.size.width + 20, image.size.height);
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    self.navigationItem.rightBarButtonItem = createButton;
    [createButton release];   
    
    UIImageView *bubbleImage = [[UIImageView alloc] initWithFrame:CGRectMake(30., 165., 240., 100.)];
    bubbleImage.image = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:14. topCapHeight:30.];
    [self.view addSubview:bubbleImage];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setBackgroundImage:[UIImage imageNamed:@"ButtonOrange.png"] forState:UIControlStateNormal];
    [moreButton setTitle:@"More" forState:UIControlStateNormal];
    moreButton.frame = CGRectMake(214., 183., 90., 40.);
    [moreButton addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    moreButton.transform = CGAffineTransformMakeRotation(0.3);
    [self.view addSubview:moreButton];
    
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
    
    GOFetchVideo *fetchVideoData = [[GOFetchVideo alloc] initWithArtistName:[gigEvent artistName]];
    [fetchVideoData setDelegate:self]; 
    [fetchVideoData retrieveVideoData];
}

- (void)onCreate:(id)sender{

    GOFetch4SqVenueId *venueId = [[GOFetch4SqVenueId alloc] initWithGigObject:gigEvent];
    [venueId setDelegate:self];
    [venueId retrieve4SqVenueId];

    
}

- (void)showMore{
    
    GOFetchSentiment *fetchSentiment = [[GOFetchSentiment alloc] initWithArtistName:gigEvent.artistName];
    [fetchSentiment setDelegate:self];
    [fetchSentiment retrieveSentimentData];
}


#pragma mark -
#pragma mark GOFetchVideoDelegate implementation
- (void)fetchVideoRequestDidFinishWithArray:(NSArray *)gigsVideoArray
{
    [gigEvent setVideoArray:gigsVideoArray];
    [videoTableView reloadData];
}

- (void)fetchRequestDidFinishWithVenueId:(NSString *)venue4SqId
{
    [self postHangoutEventWithId:venue4SqId];
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Venue id is" message:[NSString stringWithFormat:@"%@",venue4SqId] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
//    [alert show];
//    [alert release];
}


#pragma mark -
#pragma mark GOFetchSentimentDelegate implementation
- (void)fetchSentimentRequestDidFinishWithMessage:(NSString *)sentimentMessage;
{
    if (!sentimentMessage) {
        sentimentMessage = @"No sentiments found";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Track Sentiment" 
                                                    message:sentimentMessage
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

#pragma mark - View lifecycle

- (void)postHangoutEventWithId:(NSString *)hangoutId{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangout"
                                                     message:@"Hangout created succesfully!" 
                                                    delegate:nil 
                                           cancelButtonTitle:@"OK" 
                                           otherButtonTitles:nil];
    [alert show];
    [alert release];
//    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_ENDPOINT, SOCIALS_PATH]];
//    
//    NSLog(@"Publish hangout url:%@", url);
//    ASIFormDataRequest* m_formRequest = [[ASIFormDataRequest alloc] initWithURL:url];
//    [m_formRequest setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
//        
//    NSError * error = nil;
//    NSString * password = @"$2a$10$VFfwe7PT6T99kw4nEMJ89OJR53l5VIM625usghQrbPIYuGXKaCR96";
//    if (error) {
//        NSLog(@"Key Chain error:%@", [error localizedDescription]);
//        return;
//    }
//    
//    [m_formRequest setRequestMethod:@"POST"];
//    [m_formRequest setUsername:@"4ed949fde1bfdf0001000005"];
//    [m_formRequest setPassword: password];
//    [m_formRequest setPostValue:gigEvent.gigName forKey:@"name"];
//    [m_formRequest setPostValue:@"4ed949fde1bfdf0001000005" forKey:@"user_id"];
//    [m_formRequest setPostValue:gigEvent.venueName forKey:@"long_description"];
//    [m_formRequest setPostValue:[NSDate date] forKey:@"start_date_time"];
//    [m_formRequest setPostValue:[NSNumber numberWithBool:YES] forKey:@"is_public"];
//    [m_formRequest setPostValue:[NSNumber numberWithBool:NO] forKey:@"post_to_facebook"];
//    [m_formRequest setPostValue:[NSNumber numberWithInt:1000] forKey:@"capacity"];
////    [m_formRequest setPostValue:[_selectedOrientations componentsJoinedByString: @","] forKey:@"orientations"];
////    [m_formRequest setPostValue:[_selectedRelationships componentsJoinedByString: @","] forKey:@"relationship_type_categories"];
//    [m_formRequest setPostValue:@"Male" forKey:@"hangout_gender_id"];
//    [m_formRequest setPostValue:[NSNumber numberWithInt:24] forKey:@"age_min"];
//    [m_formRequest setPostValue:[NSNumber numberWithInt:80] forKey:@"age_max"];
//    
//    [m_formRequest setPostValue:@"4e4a7c0a28d22d0002000056" forKey:@"main_venue_id"];
//    [m_formRequest setPostValue:@"Party" forKey:@"tag_list"];
//    [m_formRequest setDelegate:self];
//    [m_formRequest startAsynchronous];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

// Called when a request starts, lets the delegate know via didStartSelector
- (void)didReceiveDataSelector:(NSData *)data{
    NSString *string = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
    NSLog(@"Data receiveed %@", string);
}

- (void)requestStarted{
    NSLog(@"Data Started");

}

// Called when a request completes successfully, lets the delegate know via didFinishSelector
- (void)requestFinished{
    NSLog(@"Data finished");
}

// Called when a request fails, and lets the delegate know via didFailSelector
- (void)failWithError:(NSError *)theError{
    
    NSLog(@"Data error %@", [theError userInfo]);
}

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
