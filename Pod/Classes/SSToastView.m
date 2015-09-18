//
//  SSToastView.m
//  Pods
//
//  Created by Shingwa Six on 15/9/18.
//
//

#import "SSToastView.h"

@interface SSToastView ()
@property (weak, nonatomic) UILabel *textLabel;
@end

@implementation SSToastView

+ (instancetype)shareInstance
{
    static SSToastView *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[SSToastView alloc] initWithFrame:CGRectMake(0, 30, 320, 28)];
        _shareInstance.alpha = 0.0;
        [[UIApplication sharedApplication].keyWindow addSubview:_shareInstance];
    });
    return _shareInstance;
}

+ (instancetype)toastView
{
    SSToastView *toastView = [[SSToastView alloc] initWithFrame:CGRectMake(0, 30, 320, 28)];
    toastView.alpha = 0.0;
    return toastView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 3.0;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeZero;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        frame.origin = CGPointZero;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
        [textLabel setFont:[UIFont systemFontOfSize:(frame.size.height / 2)]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [textLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

+ (void)show:(NSString *)text
{
    [[self toastView] show:text];
}

- (void)show:(NSString *)text
{
    CGSize size = [text sizeWithFont:self.textLabel.font];
    CGRect frame = self.frame;
    frame.size.width = size.width + 20;
    frame.origin.x = (320 - frame.size.width) / 2;
    [self setFrame:frame];
    
    [self.textLabel setText:text];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self.layer performSelectorOnMainThread:@selector(removeAllAnimations) withObject:nil waitUntilDone:YES];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2.2 delay:0.0 options:(UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        weakSelf.alpha = 0.8;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.alpha = 0.0;
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];
        } else {
            [weakSelf removeFromSuperview];
        }
    }];
}

@end