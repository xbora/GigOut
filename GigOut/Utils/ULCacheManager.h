//
//  STLCacheManager.h
//  SogeoManTouchLib
//
//  Created by James Bryan Graves on 3/4/11.
//  Copyright 2011 SoGeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ULCacheManager : NSObject {
	NSString *_dataPath;
}

-(void)clearCache;
-(NSData*)getCachedData:(NSURL*)url;
-(void)cacheData:(NSData*)data fromURL:(NSURL*)url modificationDate:(NSDate*)modDate;
-(NSDate*)getFileModificationDate:(NSString*)filePath;

+(ULCacheManager*)sharedInstance;

@end
