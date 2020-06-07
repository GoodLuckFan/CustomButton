//
//  ViewController.m
//  ReplyDemo
//
//  Created by FLH on 2020/6/7.
//  Copyright © 2020年 FLH. All rights reserved.
//

#import "ViewController.h"
#import "ReplyView.h"

@interface ViewController ()

@property(nonatomic,strong) ReplyView * replyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button =   [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 200, 200, 30);
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction: (UIButton *)button{
    [self.view addSubview:self.replyView];
}

-(ReplyView *)replyView{
    if (!_replyView) {
        ReplyView *reply = [[ReplyView alloc] initWithFrame:self.view.bounds];
        reply.backgroundColor = [UIColor clearColor];
        reply.hiddenDelegate = self;
        _replyView = reply;
        
    }
    [_replyView.textview becomeFirstResponder];
    return _replyView;
}



@end
