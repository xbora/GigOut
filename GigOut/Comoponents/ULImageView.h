//
//  ULImageView.h
//  UberLife
//
//  Created by James Graves on 10/31/11.
//  Copyright (c) 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLCacheConnection.h"

@class ULImageView;

@protocol ULImageViewDelegate <NSObject>

@optional
-(void)imageLoaded:(ULImageView*)imageView;
-(void)imageViewTapped:(ULImageView*)imageView;

@end

@interface ULImageView : UIView <URLCacheConnectionDelegate> {
	
	BOOL _animate;
	UIActivityIndicatorView *_actView;
	UIImage *_defaultImage;
	UIImageView *_defaultView;
	UIImageView *_loadedView;
	id<ULImageViewDelegate> _delegate;
	URLCacheConnection *_urlConnection;
	NSString *_urlStr;
}

@property(nonatomic,assign)BOOL animate;
@property(nonatomic,retain)UIImage *defaultImage;
@property(nonatomic,retain)IBOutlet id<ULImageViewDelegate> delegate;
@property(nonatomic,readonly)UIImageView *loadedView;
@property(nonatomic,readonly)UIImage *image;
@property(nonatomic,retain)NSString* urlStr;

@end
