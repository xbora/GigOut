//
//  GOGigDetailTableViewCell.m
//  OstuniToGo
//
//  Created by luigi br on 11/11/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOGigDetailTableViewCell.h"

#define kWebViewPadding 10.

@interface GOGigDetailTableViewCell ()

@property (nonatomic, retain) NSString  *urlString;

- (void)embedYouTube:(NSString*)url forWebView:(UIWebView *)webView;
- (void)defaultCell;

@end

@implementation GOGigDetailTableViewCell

@synthesize videoLabel;
@synthesize urlString;

- (void)dealloc{

    self.videoLabel = nil;
    self.urlString = nil;
    [super dealloc];
}
- (id)initWithUrlString:(NSString *)_url reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.urlString = _url;
        
        [self defaultCell];
       // [self performSelectorOnMainThread:@selector(defaultCell) withObject:nil waitUntilDone:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];
}

- (void)defaultCell{
        
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(kWebViewPadding*2, kWebViewPadding, 90., 60.)];
    videoView.backgroundColor = [UIColor blackColor];
    [self embedYouTube:urlString forWebView:videoView];
    [self addSubview:videoView];
    
    self.videoLabel = [[[UILabel alloc] initWithFrame:
                        CGRectMake(CGRectGetWidth(videoView.frame) + 45, kWebViewPadding, 163, 60)] autorelease];
    videoLabel.numberOfLines = 3;
    videoLabel.backgroundColor = [UIColor clearColor];
    videoLabel.textAlignment = UITextAlignmentLeft;
    videoLabel.font = [UIFont systemFontOfSize:14.];
    videoLabel.textColor = [UIColor grayColor];
    [self addSubview:videoLabel];
}

- (void)embedYouTube:(NSString*)url forWebView:(UIWebView *)webView{  
    NSString* embedHTML = @"<html><head><style type=\"text/css\">\
    body {background-color: transparent; color: black;}</style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"\
    width=\"%f\" height=\"%f\"></embed></body></html>";  
    
    NSString* html = [NSString stringWithFormat:embedHTML, url, webView.frame.size.width, webView.frame.size.height];

    [webView loadHTMLString:html baseURL:nil];  
}
@end
