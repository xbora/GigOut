//
//  GODetailViewController.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ULImageView.h"
#import "GOGig.h"

@interface GODetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    ULImageView *artistImage;
    UILabel     *venueDetailLabel;
    UILabel     *startDateLabel;
    UITableView *videoTableView;
    
    GOGig       *gigEvent;
}

- (id)initWithGOGig:(GOGig *)_gigEvent;

@end
