#import "YouTubeDataAPI.h"

@interface YouTubeDataAPI() <NSURLSessionDelegate>
@end

@implementation YouTubeDataAPI {
	void (^completionHandler)(NSString *);
}

-(id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}
-(void)getDislike:(NSString *)videoID completion:(void (^)(NSString *))block {

	completionHandler = block;

	NSMutableURLRequest *request = [NSMutableURLRequest new];
	NSString *apiURL = [self getAPIURLWith:videoID];

	[request setURL:[NSURL URLWithString:apiURL]];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setValue:@"identity" forHTTPHeaderField:@"Accept-encording"];
	[request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[request setHTTPMethod:@"GET"];

	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	sessionConfig.timeoutIntervalForRequest  =  10;
	sessionConfig.timeoutIntervalForResource =  20;

	self.sessionConnect = [NSURLSession sessionWithConfiguration: sessionConfig delegate: self delegateQueue: [NSOperationQueue mainQueue]];

	NSURLSessionDataTask *dataTask = [self.sessionConnect dataTaskWithRequest:request];
	[dataTask resume];

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
	NSNumber *num = json[@"dislikes"];
	NSInteger dislike = [num integerValue];
	if (!dislike) return;//高評価と低評価がOFFの動画の場合
	completionHandler([NSString stringWithFormat:@"%ld",(long)dislike]);
}

-(NSString *)getAPIURLWith:(NSString *)videoID {
	return [[NSString alloc] initWithFormat:@"https://returnyoutubedislikeapi.com/votes?videoId=%@",videoID];
}
@end