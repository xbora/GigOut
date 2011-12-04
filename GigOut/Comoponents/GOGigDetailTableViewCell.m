//
//  GOGigDetailTableViewCell.m
//  OstuniToGo
//
//  Created by luigi br on 11/11/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOGigDetailTableViewCell.h"

#define kWebViewPadding 10

@interface GOGigDetailTableViewCell ()

@property (nonatomic, retain) NSString  *urlString;

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame;
- (void)defaultCell;

@end

@implementation GOGigDetailTableViewCell

@synthesize videoView;
@synthesize videoLabel;
@synthesize urlString;

- (id)initWithUrlString:(NSString *)_url reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.urlString = _url;
        
        [self defaultCell];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];

}

- (void)defaultCell{
    
    self.videoView = [[[UIWebView alloc] initWithFrame:CGRectMake(kWebViewPadding*2, kWebViewPadding, 90., 60.)] autorelease];
    videoView.backgroundColor = [UIColor blackColor];
    [self embedYouTube:urlString frame:videoView.frame];
    [self addSubview:videoView];
    
    self.videoLabel = [[[UILabel alloc] initWithFrame:
                        CGRectMake(CGRectGetWidth(self.videoView.frame) + 45, kWebViewPadding, 163, 60)] autorelease];
    videoLabel.numberOfLines = 2;
    videoLabel.backgroundColor = [UIColor clearColor];
    videoLabel.textAlignment = UITextAlignmentLeft;
    videoLabel.font = [UIFont systemFontOfSize:16.];
    videoLabel.textColor = [UIColor grayColor];
    [self addSubview:videoLabel];
}

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame {  
    NSString* embedHTML = @"<html><head><style type=\"text/css\">\
    body {background-color: transparent; color: black;}</style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"\
    width=\"%f\" height=\"%f\"></embed></body></html>";  
    
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];

    [self.videoView loadHTMLString:html baseURL:nil];  
}
@end
