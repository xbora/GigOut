//
//  GOMasterViewController.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOMasterViewController.h"
#import "GODetailViewController.h"
#import "GOMasterTableViewCell.h"
#import "ULImageView.h"
#import "DateUtils.h"
#import "GOGig.h"
#import "GOFetchGigsOperation.h"

#import <CoreLocation/CoreLocation.h>

@interface GOMasterViewController ()

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSArray *gigsArray;

- (void)defineCellFields:(GOMasterTableViewCell *)cell withGigEvent:(GOGig *)gigEvent;

@end

@implementation GOMasterViewController

@synthesize activityIndicator;
@synthesize gigsArray;
@synthesize operationQueue = operationQueue_;

- (void)dealloc
{
    self.gigsArray = nil;
    [operationQueue_ release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Gigs Around you",nil);
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        activityIndicator.frame = CGRectMake(140, 180, 40, 40);
        [self.view addSubview:activityIndicator];
        
        self.tableView.rowHeight = 84;
        
        [[LocationManager sharedLocationManager] setDelegate:self];
        [[LocationManager sharedLocationManager] startUpdates];
    }
    return self;
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    operationQueue_ = [[NSOperationQueue alloc] init];
    [self loadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadData {
    [[self operationQueue] cancelAllOperations];
    GOFetchGigsOperation *operation = [[GOFetchGigsOperation alloc] init];
    operation.delegate = self;
    [[self operationQueue] addOperation: operation];
    
    if (activityIndicator != nil) {
        [activityIndicator startAnimating];
    }
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gigsArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    GOMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GOMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    UIImageView* lineView = (UIImageView*)[cell.contentView viewWithTag:LINE_TAG];
    
    if (indexPath.row == 0)
    {
        UIImage *lineImage = [[UIImage imageNamed:@"BACK-RowSocialsNoLine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        lineView.image = lineImage;
        CGRect frame = lineView.frame;
        frame.size.height = 83;
        lineView.frame = frame;
    } else {
        UIImage *lineImage = [[UIImage imageNamed:@"BACK-RowSocials.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        lineView.image = lineImage;
        CGRect frame = lineView.frame;
        frame.size.height = 84;
        lineView.frame = frame;
    }
    
    GOGig *gigEvent = (GOGig*)[self.gigsArray objectAtIndex:indexPath.row];
    if(gigEvent) {
        [self defineCellFields:cell withGigEvent:gigEvent];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GODetailViewController *detailViewController = [[GODetailViewController alloc] initWithGOGig:[gigsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (void)defineCellFields:(GOMasterTableViewCell *)cell withGigEvent:(GOGig *)gigEvent{
    
    ULImageView* imageView = (ULImageView*)[cell.contentView viewWithTag:IMAGE_TAG];
    imageView.urlStr = gigEvent.artistImgUrl;
    
    UILabel* titleLabel = (UILabel*)[cell.contentView viewWithTag:TITLE_TAG];
    NSString *capitalize = gigEvent.artistName;
    capitalize = [NSString stringWithFormat:@"%@%@",[[capitalize substringToIndex:1] uppercaseString],[capitalize substringFromIndex:1] ];       
    titleLabel.text = capitalize;
    
    UILabel* dateLabel =  (UILabel*)[cell.contentView viewWithTag:DATE_TAG];
    
    if(gigEvent.startDate) {      
        dateLabel.text = [gigEvent.startDate uppercaseString];
    } else {
        dateLabel.text = @"";
    }
    
    UILabel* distanceLabel = (UILabel*)[cell.contentView viewWithTag:DISTANCE_TAG];
    UILabel* venueLabel = (UILabel*)[cell.contentView viewWithTag:VENUE_TAG];        
    venueLabel.text = gigEvent.venueName;
    CLLocation* locationCoords = [[CLLocation alloc] initWithLatitude:[gigEvent.venueLat floatValue]
                                                            longitude:[gigEvent.venueLng floatValue]];
    CLLocation* currentLoc = [[LocationManager sharedLocationManager] currentLocation];
    if (currentLoc != nil) {
        float distance = [currentLoc distanceFromLocation:locationCoords] * 0.000621371192;
        
        // Make the distance different once it is more then 10 miles away.
        NSString *numberformatter = [NSString stringWithFormat:@"%0.1f", distance];
        float floattest = [numberformatter floatValue];
        if(floattest > 9.9){
            distanceLabel.text = [NSString stringWithFormat:@"%0.0f", distance];
        }
        else{
            distanceLabel.text = [NSString stringWithFormat:@"%0.1f", distance];
        }
    }
    
    [locationCoords release];
    
    //        NSArray* rsvps = [gigEvent objectForKey:@"rsvps"];
    //        int count = [rsvps count];
    //        UIImageView* circle = (UIImageView*)[cell.contentView viewWithTag:RSVP_DOT];
    //        UILabel* number = (UILabel*)[[circle subviews] objectAtIndex:0];
    //        number.text = [NSString stringWithFormat:@"%d", count];
}

#pragma mark - 
#pragma mark GOFetchGigsOperationDelegate
- (void)fetchRequestDidFinishWithArray:(NSArray *)_gigsArray{
    
    if (gigsArray) {
        self.gigsArray = nil;
    }

    self.gigsArray = [[[NSArray alloc] initWithArray:_gigsArray] autorelease];
    [self.tableView reloadData];
    
    if (activityIndicator != nil && [activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
}

#pragma mark -
#pragma mark LocationManagerDelegate

- (void)locationManagerDidUpdateLocation:(CLLocation *)location{

    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (activityIndicator != nil && [activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
