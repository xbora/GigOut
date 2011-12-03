//
//  GOMasterViewController.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOFetchGigsOperation.h"

@class GODetailViewController;

@interface GOMasterViewController : UITableViewController <GOFetchGigsOperationDelegate>
{
    NSOperationQueue *operationQueue_;  
    UIActivityIndicatorView *activityIndicator;
    NSArray *gigsArray;
}

@property (nonatomic, retain) NSOperationQueue *operationQueue;

- (void)loadData;

@end
