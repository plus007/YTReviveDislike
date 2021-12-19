#ifndef _TWEAK_H
#define _TWEAK_H
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YTWatchTransition : NSObject
@property (nonatomic, strong, readwrite) NSString *videoID;
-(id)expectedLayout;
@end

@interface YTFormattedStringLabel : UILabel
@property (nonatomic, copy, readwrite) NSAttributedString *attributedText;
@end

@interface YTSlimVideoDetailsActionView : UIView
@property (nonatomic, strong, readwrite) YTFormattedStringLabel *label;
-(id)initWithElementSlimMetadataButtonSupportedRenderer:(id)arg1 elmContext:(id)arg2;
@end

@interface YTSlimVideoScrollableDetailsActionsView : UIView
@property NSArray *subviews;
-(UIViewController *)getCurrentViewController;
-(void)setNeedsLayout;
-(void)setTextForDislikeButton:(NSString *)text;
-(void)layoutIfNeeded;
@end

#endif