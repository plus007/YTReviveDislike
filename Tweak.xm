#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YouTubeDataAPI.h"
#import "Tweak.h"

%hook YTWatchTransition
%new
-(void)receiveTraffic {
	YouTubeDataAPI *api = [[YouTubeDataAPI alloc] initWithAPIKey:@"YOUR_API_KEY"];
	[api getDislike:self.videoID completion:^(NSString *dislike) {
		NSDictionary *dic = [NSDictionary dictionaryWithObject:dislike forKey:@"Dislike"];
		NSNotification *notification = [NSNotification notificationWithName:@"Dislike" object:nil userInfo:dic];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(id)expectedLayout {
	NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
	[notification addObserver:self selector:@selector(receiveTraffic) name:@"AllowTraffic" object:nil];
	return %orig;
}

%end

%hook YTSlimVideoScrollableDetailsActionsView
NSString *dislike = @"低評価";

-(void)layoutSubviews {
	%orig;

	[self setTextForDislikeButton:dislike];
	
	NSNotification *traffic = [NSNotification notificationWithName:@"AllowTraffic" object:nil];
	[[NSNotificationCenter defaultCenter] postNotification:traffic];

	NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
	[notification addObserver:self selector:@selector(receiveDislikeCount:) name:@"Dislike" object:nil];
}

%new
-(void)receiveDislikeCount:(NSNotification *)notificaiton {
	dislike = (NSString *)[[notificaiton userInfo] objectForKey:@"Dislike"];
	if (!dislike) return;
	[self setTextForDislikeButton:dislike];
}

%new 
-(void)setTextForDislikeButton:(NSString *)text {
	YTSlimVideoDetailsActionView *actionView = MSHookIvar<YTSlimVideoDetailsActionView *>(self,"_dislikeActionView");
	YTFormattedStringLabel *label = actionView.label;

	NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:attributes];

	label.textAlignment = 4;
	label.attributedText = attributedString;
}

%end
