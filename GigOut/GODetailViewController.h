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
#import "GOFetchVideoOperation.h"

@interface GODetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GOFetchVideoOperationDelegate>{
    
    ULImageView *artistImage;
    UILabel     *detailDescriptionLabel;
    UITableView *videoTableView;
    NSOperationQueue *operationQueue;
    
    GOGig       *gigEvent;
}

- (id)initWithGOGig:(GOGig *)_gigEvent;

@end
