//
//  GOFetchVideoOperation.m
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOFetchVideoOperation.h"

@implementation GOFetchVideoOperation

@synthesize delegate;
@synthesize artistName = _artistName;

- (id) initWithArtistName:(NSString *)artistName
{
    self = [super init];
    if (self)
    {
        _artistName = artistName;
    }
    return self;
}

#pragma mark - Cleanup

- (void) dealloc
{
    self.delegate = nil;
    [super dealloc];
}

#pragma mark - Operation main method

- (void) main
{
    @try {        
        //check to see if we have been cancelled.
        if (![self isCancelled])
        {
            
            // Change the request with the youtube video one!
            
            NSMutableArray *gigs = [[NSMutableArray alloc] init];
            NSString *fetchUrlString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?v=2&alt=jsonc&q=%@", [_artistName stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding]];
            NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
            NSStringEncoding encoding;
            
            //fetch data from web service
            NSString *jsonString = [NSString stringWithContentsOfURL:fetchUrl usedEncoding:&encoding error:nil];
            
            NSError *jsonError = nil;
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            
            //check to see if we have been cancelled
            if (![self isCancelled] && dictionary != nil)
            {                    
                NSArray *data = [[dictionary objectForKey:@"data"] objectForKey:@"items"];
                if (data) {
                    for (NSDictionary *item in data)
                    {
                        GOGigVideoInfo *videoInfo = [[GOGigVideoInfo alloc] init];
                        [videoInfo setVideoDescription:[item objectForKey:@"description"]];
                        [videoInfo setVideoStringUrl:[[item objectForKey:@"player"] objectForKey:@"mobile"]];
                        [gigs addObject:videoInfo];
                        NSLog(@"mobile is: %@", [[item objectForKey:@"player"] objectForKey:@"mobile"] );
                    }                    
                }
            }
            
            if (delegate != nil &&
                [delegate respondsToSelector:@selector(fetchVideoRequestDidFinishWithArray:)]){
                [delegate fetchVideoRequestDidFinishWithArray:gigs];
            }
            
            [gigs release];
        }  
    }
    @catch (NSException *e) {
        NSLog(@"%@", e);
    }
    

}

@end
