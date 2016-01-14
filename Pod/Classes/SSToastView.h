//
//  SSToastView.h
//  Pods
//
//  Created by Shingwa Six on 15/9/18.
//
//

#import <UIKit/UIKit.h>

@interface SSToastView : UIView

@property (assign, nonatomic) NSTimeInterval fadeInDuration UI_APPEARANCE_SELECTOR; //default is 1.2
@property (assign, nonatomic) NSTimeInterval fadeOutDuration UI_APPEARANCE_SELECTOR; //default is 0.5
@property (assign, nonatomic) NSTimeInterval delay UI_APPEARANCE_SELECTOR; //default is 2.4

+ (instancetype)shareInstance;

+ (void)show:(NSString *)text;
- (void)show:(NSString *)text;

@end
