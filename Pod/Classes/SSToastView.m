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
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [self new];
    });
    return shareInstance;
}

+ (void)load
{
    [[self appearance] setFadeInDuration:0.8f];
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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.userInteractionEnabled = NO;
    
    self.alpha = 0.0;
    
    self.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeZero;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    UILabel *textLabel = [UILabel new];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:14.0];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.numberOfLines = 0;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.userInteractionEnabled = NO;
    
    [self addSubview:textLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-5]];
    self.textLabel = textLabel;
}

+ (void)show:(NSString *)text
{
    [[self shareInstance] show:text];
}

- (void)show:(NSString *)text
{
    if ([[NSThread currentThread] isMainThread]) {
        [self _show:text];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _show:text];
        });
    }
}

- (void)_show:(NSString *)text
{
    [self.textLabel setText:text];
    
    if (!self.superview) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeTop multiplier:1 constant:23]];
        [window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:window attribute:NSLayoutAttributeLeading multiplier:1 constant:5]];
        [window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }
    [self layoutIfNeeded];
    
    [self.layer removeAllAnimations];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = self.fadeInDuration + self.delay + self.fadeOutDuration;
    animation.values = @[@(0.5),@(1.0),@(1.0),@(0.0)];
    animation.keyTimes = @[
                           @(0.0),
                           @(self.fadeInDuration / animation.duration),
                           @((self.fadeInDuration + self.delay) / animation.duration),
                           @(1.0)
                           ];
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"SSToastView.animation"];
}

@end
