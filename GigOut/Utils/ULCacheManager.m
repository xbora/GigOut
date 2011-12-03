//
//  STLCacheManager.m
//  SogeoManTouchLib
//
//  Created by James Bryan Graves on 3/4/11.
//  Copyright 2011 SoGeo. All rights reserved.
//

#import "ULCacheManager.h"


@implementation ULCacheManager

static ULCacheManager *_sharedInstance = nil;
+(ULCacheManager*)sharedInstance {
	if (!_sharedInstance) {
		_sharedInstance = [[ULCacheManager alloc] init];
	}
	return _sharedInstance;
}

-(id)init {
	if(self = [super init]) {		
		/* create path to cache directory inside the application's Documents directory */
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		_dataPath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"] retain];
		
		/* check for existence of cache directory */
		if (![[NSFileManager defaultManager] fileExistsAtPath:_dataPath]) {
			NSError *error;
			/* create a new cache directory */
			if (![[NSFileManager defaultManager] createDirectoryAtPath:_dataPath
										   withIntermediateDirectories:NO
															attributes:nil
																 error:&error]) {
				NSLog(@"CACHE CREATE FAIL: %@", [error localizedDescription]);
			}
		}
	}
	return self;
}

-(void)cacheData:(NSData*)data fromURL:(NSURL*)url modificationDate:(NSDate*)modDate {
	NSError *error;
	
	NSString *fileName = [url path];
	NSInteger queryIndex = [fileName rangeOfString:@"?"].location;
	if(queryIndex != NSNotFound)
		fileName = [fileName substringToIndex:queryIndex];

	NSString *filePath = [_dataPath stringByAppendingPathComponent:fileName];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES) {
		
		/* apply the modified date policy */
		
		NSDate *fileDate = [self getFileModificationDate:filePath];
		NSComparisonResult result = [modDate compare:fileDate];
		if (result == NSOrderedDescending) {
			/* file is outdated, so remove it */
			if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
				NSLog(@"CACHE REMOVE FILE FAIL: %@", [error localizedDescription]);
			}
		}
	}
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO) {
		NSString *directoryPath = [filePath stringByReplacingOccurrencesOfString:[filePath lastPathComponent] withString:@""];
		[[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
								  withIntermediateDirectories:YES
												   attributes:nil
														error:&error];
		
		/* file doesn't exist, so create it */
		[[NSFileManager defaultManager] createFileAtPath:filePath
												contents:data
											  attributes:nil];
		NSLog(@"Newly cached image");
	} else {
		NSLog(@"Cached image is up to date");
	}
	
	/* reset the file's modification date to indicate that the URL has been checked */
	
	NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSDate date], NSFileModificationDate, nil];
	if (![[NSFileManager defaultManager] setAttributes:dict ofItemAtPath:filePath error:&error]) {
		NSLog(@"CACHE MOD DATE FAIL: %@", [error localizedDescription]);
	}
	[dict release];	
}	

-(void)clearCache {
	NSError *error;
	
	/* remove the cache directory and its contents */
	if (![[NSFileManager defaultManager] removeItemAtPath:_dataPath error:&error]) {
		NSLog(@"CACHE CLEAR FAIL: %@", [error localizedDescription]);
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:_dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&error]) {
		NSLog(@"CACHE RE-CREATE FAIL: %@", [error localizedDescription]);
		return;
	}
}

-(NSData*)getCachedData:(NSURL*)url {
	NSString *filePath = [_dataPath stringByAppendingPathComponent:[url path]];
	return [[NSFileManager defaultManager] contentsAtPath:filePath];
}

-(NSDate*)getFileModificationDate:(NSString*)filePath {
	NSError *error;
	
	/* default date if file doesn't exist (not an error) */
	NSDate *fileDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		/* retrieve file attributes */
		NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
		if (attributes != nil) {
			return [attributes fileModificationDate];
		} else {
			NSLog(@"FILE MOD DATE FAIL: %@", [error localizedDescription]);
		}
	}
	return fileDate;
}

-(void)dealloc {
	[_dataPath release], _dataPath = nil;
	[super dealloc];
}

@end
