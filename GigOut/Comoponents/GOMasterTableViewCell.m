//
//  ULHangoutsCell.m
//  UberLife
//
//  Created by James Graves on 10/17/11.
//  Copyright (c) 2011 N/A. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>
#import <QuartzCore/QuartzCore.h>
#import "GOMasterTableViewCell.h"
#import "ULImageView.h"

@implementation GOMasterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:12];
        
        UIImage* triangle = [UIImage imageNamed:@"Distance.png"];
        UIImageView* triangleView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - triangle.size.width, 0, triangle.size.width, triangle.size.height)];
        triangleView.image = triangle;
        
        [self.contentView addSubview:triangleView];
        [triangleView release];
        
        UIImageView* border = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BACK-OrganiserThumbnail.png"]];
        border.frame = CGRectMake(0, 0, 58, 58);
        border.center = CGPointMake(43, 43);
        [self.contentView addSubview:border];
        [border release];
        
        ULImageView* imageView = [[ULImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
        imageView.tag = IMAGE_TAG;
        imageView.center = CGPointMake(43, 43);
        imageView.layer.cornerRadius = 5.0f;
        imageView.layer.masksToBounds = YES;
        imageView.defaultImage = [UIImage imageNamed:@"placeholder.png"];
        
        [self.contentView addSubview:imageView];
        [imageView release];
        
        // No attending number required
//        UIImageView* circle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Counter.png"]];
//        circle.frame = CGRectMake(50, 50, 27, 27);
//        circle.tag = RSVP_DOT;
//        
//        UILabel* number = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
//        number.backgroundColor = [UIColor clearColor];
//        number.textColor = [UIColor whiteColor];
//        number.textAlignment = UITextAlignmentCenter;
//        number.font = [UIFont boldSystemFontOfSize:13];
//        number.text = @"0";
//        number.shadowColor = [UIColor colorWithRed:0.88 green:0.24 blue:0.015 alpha:1.0f];
//        number.shadowOffset = CGSizeMake(0,-1);
//        number.numberOfLines = 1;
//        
//        [circle addSubview:number];
//        [number release];
//        
//        [self.contentView addSubview:circle];
//        [circle release];
                
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 13, 190, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.0f];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.tag = TITLE_TAG;
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0,1);
        titleLabel.text = @"Title not available";
        
        [self.contentView addSubview:titleLabel];
        [titleLabel release];
        
        UILabel* venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 30, 190, 20)];
        venueLabel.backgroundColor = [UIColor clearColor];
        venueLabel.textColor = [UIColor colorWithWhite:0.647 alpha:1.0f];
        venueLabel.font = [UIFont boldSystemFontOfSize:12];
        venueLabel.tag = VENUE_TAG;
        venueLabel.shadowColor = [UIColor whiteColor];
        venueLabel.shadowOffset = CGSizeMake(0,1);
        venueLabel.text = @"Venue not available";
        [self.contentView addSubview:venueLabel];
        [venueLabel release];
        
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 50, 190, 20)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = [UIColor colorWithWhite:0.65 alpha:1.0f];
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.shadowColor = [UIColor whiteColor];
        dateLabel.shadowOffset = CGSizeMake(0,1);
        dateLabel.tag = DATE_TAG;
        
        NSString* dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle];
        dateLabel.text = dateString;
        
        [self.contentView addSubview:dateLabel];
        [dateLabel release];
        
        UILabel* distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(268, 4, 45, 20)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor darkGrayColor];
        distanceLabel.font = [UIFont boldSystemFontOfSize:14];
        distanceLabel.tag = DISTANCE_TAG;
        distanceLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.8f];
        distanceLabel.shadowOffset = CGSizeMake(0,1);
        distanceLabel.text = @"88.8";
        distanceLabel.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:distanceLabel];
        [distanceLabel release];
        
        UILabel* mileLabel= [[UILabel alloc] initWithFrame:CGRectMake(283, 15, 45, 20)];
        mileLabel.backgroundColor = [UIColor clearColor];
        mileLabel.textColor = [UIColor colorWithRed:0.584 green:0.584 blue:0.584 alpha:1.0f];
        mileLabel.font = [UIFont boldSystemFontOfSize:10];
        mileLabel.tag = DISTANCE_TAG;
        mileLabel.text = @"mi.";
        mileLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.6f];
        mileLabel.shadowOffset = CGSizeMake(0,1);
        mileLabel.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:mileLabel];
        [mileLabel release];
        
        UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 83)];
        lineImageView.tag = LINE_TAG;
        
        [self.contentView addSubview:lineImageView];
        [self.contentView sendSubviewToBack: lineImageView];
        
        [lineImageView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    
}

@end
