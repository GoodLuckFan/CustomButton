//
//  ViewController.m
//  CustomButton
//
//  Created by FLH on 2020/5/10.
//  Copyright © 2020年 FLH. All rights reserved.
//

#import "ViewController.h"
#import "WLButton.h"

#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WLButton *button = [WLButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENWIDTH / 2.0 - 30, 200, 60, 80);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    
}


@end
