#import <Foundation/Foundation.h>

@interface YouTubeDataAPI : NSObject
-(id)initWithAPIKey:(NSString *)apiKey;
-(void)getDislike:(NSString *)videoID completion:(void (^)(NSString *))block;
@property (nonatomic, strong, readwrite) NSString *apiKey;
@property (nonatomic) NSURLSession *sessionConnect;
@property (nonatomic) NSMutableData *recevedData;
@end