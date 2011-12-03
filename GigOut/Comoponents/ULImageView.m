//
//  ULImageView.m
//  UberLife
//
//  Created by James Graves on 10/31/11.
//  Copyright (c) 2011 N/A. All rights reserved.
//

#import "ULCacheManager.h"
#import "ULImageView.h"

#define THEME_ANIMATION_DURATION 0.25

@implementation ULImageView

@synthesize animate = _animate;
@synthesize defaultImage = _defaultImage;
@synthesize delegate = _delegate;
@synthesize loadedView = _loadedView;
@synthesize urlStr = _urlStr;

-(void)addViews {
	_loadedView = [[UIImageView alloc] init];
	_loadedView.backgroundColor = [UIColor blackColor];
	[self addSubview:_loadedView];
	
	_defaultView = [[UIImageView alloc] init];
	_defaultView.backgroundColor = [UIColor blackColor];
	[self addSubview:_defaultView];
	
	_actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	_actView.hidesWhenStopped = YES;
	[self addSubview:_actView];
}

-(void)toLoadedImage:(UIImage*)loadedImage {
	[_urlConnection.connection cancel];
	
	if(_animate) {
		[UIView transitionFromView:_defaultView
							toView:_loadedView
						  duration:THEME_ANIMATION_DURATION
						   options:UIViewAnimationOptionTransitionFlipFromRight
						completion:nil];
        [UIView animateWithDuration:THEME_ANIMATION_DURATION delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            _loadedView.alpha = 0.0;
        } completion:^(BOOL finished) {
            _loadedView.image = loadedImage;
            [UIView animateWithDuration:THEME_ANIMATION_DURATION delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                _loadedView.alpha = 1.0;
            } completion:nil];
        }];
        
	} else {
        _loadedView.image = loadedImage;
		[self bringSubviewToFront:_loadedView];
		[self bringSubviewToFront:_actView];
		[self setNeedsDisplay];
	}
    if([_delegate respondsToSelector:@selector(imageLoaded:)]) {
        [_delegate imageLoaded:self];
    }
	[_actView stopAnimating];
}

-(UIImage*)image {
	return _loadedView.image;
}

-(id)init {
	if((self = [super init])) {
		self.contentMode = UIViewContentModeRedraw;
		[self addViews];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		self.contentMode = UIViewContentModeRedraw;
		[self addViews];
		_loadedView.frame = CGRectMake(0,
									   0,
									   self.frame.size.width,
									   self.frame.size.height);
		_defaultView.frame = CGRectMake(0,
										0,
										self.frame.size.width,
										self.frame.size.height);
		_actView.frame = CGRectMake((self.frame.size.width / 2) - (_actView.frame.size.width / 2),
									(self.frame.size.height / 2) - (_actView.frame.size.height / 2),
									_actView.frame.size.width,
									_actView.frame.size.height);
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
		self.contentMode = UIViewContentModeRedraw;
		[self addViews];
		_loadedView.frame = CGRectMake(0,
									   0,
									   self.frame.size.width,
									   self.frame.size.height);
		_defaultView.frame = CGRectMake(0,
										0,
										self.frame.size.width,
										self.frame.size.height);
		_actView.frame = CGRectMake((self.frame.size.width / 2) - (_actView.frame.size.width / 2),
									(self.frame.size.height / 2) - (_actView.frame.size.height / 2),
									_actView.frame.size.width,
									_actView.frame.size.height);
	}
	return self;
}

-(void)setDefaultImage:(UIImage*)defaultImage {
	[_urlConnection.connection cancel];
	
	_defaultView.image = defaultImage;
	if(_animate) {
		[UIView transitionFromView:_loadedView
							toView:_defaultView
						  duration:THEME_ANIMATION_DURATION
						   options:UIViewAnimationOptionTransitionFlipFromLeft
						completion:nil];
	}  else {
		[self bringSubviewToFront:_defaultView];
		[self bringSubviewToFront:_actView];
		[self setNeedsDisplay];
	}
}

-(void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	
	_loadedView.frame = CGRectMake(0,
								   0,
								   self.frame.size.width,
								   self.frame.size.height);
	_defaultView.frame = CGRectMake(0,
									0,
									self.frame.size.width,
									self.frame.size.height);
	_actView.frame = CGRectMake((self.frame.size.width / 2) - (_actView.frame.size.width / 2),
								(self.frame.size.height / 2) - (_actView.frame.size.height / 2),
								_actView.frame.size.width,
								_actView.frame.size.height);
}

-(void)setUrlStr:(NSString*)urlStr {
	[_urlConnection.connection cancel];
	
	_urlStr = [urlStr copy];
	
	[self bringSubviewToFront:_defaultView];
	[self bringSubviewToFront:_actView];
	
	if(_urlStr && _urlStr.length > 0) {
		NSURL *url = [NSURL URLWithString:_urlStr];
		NSData *data = [[ULCacheManager sharedInstance] getCachedData:url];
		
		if(!data) {
			[_actView startAnimating];
            _urlConnection = [[URLCacheConnection alloc] initWithURL:url delegate:self];
		} else {
			[self toLoadedImage:[UIImage imageWithData:data]];
		}
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if([_delegate respondsToSelector:@selector(imageViewTapped:)])
		[_delegate imageViewTapped:self];
}

#pragma mark -
#pragma mark URLCacheConnectionDelegate methods

-(void)connectionDidFail:(URLCacheConnection*)theConnection {
	//TODO: handle this - JBG
	NSLog(@"TRAGIC IMAGE LOAD FAIL");
	[_actView stopAnimating];
}

-(void)connectionDidFinish:(URLCacheConnection*)theConnection {
	if(theConnection.receivedData) {
		NSURL *url = [NSURL URLWithString:_urlStr];
		[[ULCacheManager sharedInstance] cacheData:theConnection.receivedData
													fromURL:url
										   modificationDate:theConnection.lastModified];
		UIImage *loadedImage = [UIImage imageWithData:theConnection.receivedData];
		[self toLoadedImage:loadedImage];
	}
}

-(void)dealloc {
	[_actView release], _actView = nil;
	[_defaultImage release], _defaultImage = nil;
	[_defaultView release], _defaultView = nil;
    [_delegate release], _delegate = nil;
	[_loadedView release], _loadedView = nil;
	[_delegate release], _delegate = nil;
	[_urlConnection release], _urlConnection = nil;
	[_urlStr release], _urlStr = nil;
	[super dealloc];
}

@end
