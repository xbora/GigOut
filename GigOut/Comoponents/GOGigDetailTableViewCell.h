//
//  GOGigDetailTableViewCell.h
//  OstuniToGo
//
//  Created by luigi br on 11/11/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOGigDetailTableViewCell : UITableViewCell{
    
    UILabel   *videoLabel;
    NSString  *urlString;
}

@property (nonatomic, retain) UILabel  *videoLabel;

- (id)initWithUrlString:(NSString *)_url reuseIdentifier:(NSString *)reuseIdentifier;

@end
