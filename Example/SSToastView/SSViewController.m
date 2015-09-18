//
//  SSViewController.m
//  SSToastView
//
//  Created by Shingwa Six on 09/18/2015.
//  Copyright (c) 2015 Shingwa Six. All rights reserved.
//

#import "SSViewController.h"
#import "SSToastView.h"

@interface SSViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

- (IBAction)showAction:(id)sender;
@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SSToastView show:@"啦啦啦啦啦啦啦～"];
}

- (IBAction)showAction:(id)sender
{
    [SSToastView show:self.messageTextField.text];
}

@end
