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
        _shareInstance = [[SSToastView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 28)];
        _shareInstance.alpha = 0.0;
        [[UIApplication sharedApplication].keyWindow addSubview:_shareInstance];
    });
    return _shareInstance;
}

+ (instancetype)toastView
{
    SSToastView *toastView = [[SSToastView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 28)];
    toastView.alpha = 0.0;
    return toastView;
}

+ (void)initialize
{
    [[self appearance] setFadeInDuration:1.2f];
    [[self appearance] setFadeOutDuration:0.5f];
    [[self appearance] setDelay:2.4f];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[UINavigationBar appearance] setTranslucent:YES];
    
    self.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeZero;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    CGRect frame = self.frame;
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

+ (void)show:(NSString *)text
{
    [[self toastView] show:text];
}

- (void)show:(NSString *)text
{
    CGSize size = [text sizeWithFont:self.textLabel.font];
    CGRect frame = self.frame;
    frame.size.width = size.width + 20;
    frame.origin.x = ([UIScreen mainScreen].bounds.size.width - frame.size.width) / 2;
    [self setFrame:frame];
    
    [self.textLabel setText:text];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self.layer performSelectorOnMainThread:@selector(removeAllAnimations) withObject:nil waitUntilDone:YES];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.fadeInDuration delay:0.0 options:(UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:self.fadeOutDuration delay:self.delay options:0 animations:^{
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