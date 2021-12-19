#ifndef _YOUTUBE_H
#define _YOUTUBE_H
#import <Foundation/Foundation.h>

@interface YouTubeDataAPI : NSObject
-(id)init;
-(void)getDislike:(NSString *)videoID completion:(void (^)(NSString *))block;
@property (nonatomic) NSURLSession *sessionConnect;
@property (nonatomic) NSMutableData *recevedData;
@end
#endif