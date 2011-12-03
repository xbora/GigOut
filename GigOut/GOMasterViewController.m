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
#import "LocationManager.h"
#import "GOGig.h"
#import "GOFetchGigsOperation.h"

#import <CoreLocation/CoreLocation.h>

@interface GOMasterViewController ()

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSArray *gigsArray;

@end

@implementation GOMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize activityIndicator;
@synthesize gigsArray;
@synthesize operationQueue = operationQueue_;

- (void)dealloc
{
    self.gigsArray = nil;
    [_detailViewController release];
    [operationQueue_ release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Gigs Around you",nil);
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        activityIndicator.frame = CGRectMake(140, 240, 40, 40);
        [self.view addSubview:activityIndicator];
        self.tableView.rowHeight = 84;
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
    
    UIImage* lineImage;
    if (indexPath.row == 0)
    {
        lineImage = [[UIImage imageNamed:@"BACK-RowSocialsNoLine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        lineView.image = lineImage;
        CGRect frame = lineView.frame;
        frame.size.height = 83;
        lineView.frame = frame;
    } else {
        lineImage = [[UIImage imageNamed:@"BACK-RowSocials.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        lineView.image = lineImage;
        CGRect frame = lineView.frame;
        frame.size.height = 84;
        lineView.frame = frame;
    }
    
    GOGig *gigEvent = (GOGig*)[self.gigsArray objectAtIndex:indexPath.row];
    
    if(gigEvent) {
        ULImageView* imageView = (ULImageView*)[cell.contentView viewWithTag:IMAGE_TAG];
        NSString* eventImageUrlString = gigEvent.artistImgUrl;
        NSLog(@"The image url is %@",gigEvent.artistImgUrl);
        imageView.urlStr = eventImageUrlString;
        
        UILabel* titleLabel = (UILabel*)[cell.contentView viewWithTag:TITLE_TAG];
        NSString *capitalize = gigEvent.artistName;
        capitalize = [NSString stringWithFormat:@"%@%@",[[capitalize substringToIndex:1] uppercaseString],[capitalize substringFromIndex:1] ];       
        titleLabel.text = capitalize;
        
        UILabel* dateLabel =  (UILabel*)[cell.contentView viewWithTag:DATE_TAG];
        
        if(gigEvent.startDate) {
//            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//            [formatter setDateFormat:@"EEEE, d MMM yyyy hh:mm aaa"];
//            NSString *theString = [formatter stringFromDate:gigEvent.startDate];
//            NSString *capitalize = theString;
//            capitalize = [NSString stringWithFormat:@"%@%@",[[capitalize substringToIndex:1] uppercaseString],[capitalize substringFromIndex:1] ];       
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
        
        [locationCoords release];
        
//        NSArray* rsvps = [gigEvent objectForKey:@"rsvps"];
//        int count = [rsvps count];
//        UIImageView* circle = (UIImageView*)[cell.contentView viewWithTag:RSVP_DOT];
//        UILabel* number = (UILabel*)[[circle subviews] objectAtIndex:0];
//        number.text = [NSString stringWithFormat:@"%d", count];
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[GODetailViewController alloc] initWithNibName:@"GODetailViewController" bundle:nil] autorelease];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 
#pragma mark GOFetchGigsOperationDelegate
- (void)fetchRequestDidFinishWithArray:(NSArray *)_gigsArray{
    
    if (gigsArray) {
        self.gigsArray = nil;
    }
    // Retrieve the information to show into the tableView
    self.gigsArray = [[[NSArray alloc] initWithArray:_gigsArray] autorelease];
    
    [self.tableView reloadData];

}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (activityIndicator != nil) {
        [activityIndicator startAnimating];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (activityIndicator != nil && [activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
}

@end
