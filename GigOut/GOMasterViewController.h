//
//  GOMasterViewController.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GODetailViewController;

@interface GOMasterViewController : UITableViewController

@property (strong, nonatomic) GODetailViewController *detailViewController;

@end
