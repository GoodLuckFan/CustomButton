//
//  ReplyView.m
//  Soulmate
//
//  Created by Hengzhi Wang on 2018/9/12.
//  Copyright © 2018年 guiguiTechnical. All rights reserved.
//

#import "ReplyView.h"
#import "NSString+Util.h"
#import "Masonry.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width


@implementation ReplyView
#pragma mark ============自定义底部文字回复bar ============
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];

        [self addSubviews];
    }

    return self;
}

-(void)addSubviews{

    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:252/255.0 alpha:1.0]; //(247,248,252,1)
    self.contentView.frame = CGRectMake(0, self.frame.size.height-45, ScreenW, 45);

    self.originalY = self.contentView.frame.origin.y;
    self.originalHeight = self.contentView.frame.size.height;
    [self addSubview:self.contentView];


    CGRect textFieldframe = CGRectMake(12, 5, ScreenW - 60 - 12-20 , self.contentView.frame.size.height-10);
    CGRect btnFrame = CGRectMake(textFieldframe.size.width+22, 5, 60, self.contentView.frame.size.height-10);

    self.textview = [[BRPlaceholderTextView alloc] initWithFrame:CGRectZero];
    self.textview.delegate = self;
    self.textview.backgroundColor = [UIColor whiteColor];
    self.textview.placeholder = @"回复";
    self.textview.font = [UIFont systemFontOfSize:14];
   // [self.textview clipCornerRadius:5 borderColor:LightTagColor];
    self.textview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textview.layer.borderWidth = 1;
    self.textview.layer.cornerRadius = 5;
    self.textview.layer.masksToBounds = YES;
    self.textview.returnKeyType = UIReturnKeyDefault;
    self.textview.inputAccessoryView = [[UIView alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];


  //  self.sendBtn = [UIButton buttonWithFrame:btnFrame borderColor:nil backColor:WhiteColor title:@"发送"];
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = btnFrame;
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.sendBtn.backgroundColor = [UIColor clearColor];
    [self.sendBtn addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];


    [self.contentView addSubview:self.textview];
    [self.contentView addSubview:self.sendBtn];

    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.width.equalTo(@(textFieldframe.size.width));
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.centerY.mas_equalTo(self.contentView);
    }];

    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInBackView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];

}
-(void)tapInBackView:(UITapGestureRecognizer *)tap{
//    self.textview.text = nil;
//    self.textview.PlaceholderLabel.hidden = NO;
    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{

        [self removeFromSuperview];
    }];

    if (self.textview.text!=nil && [self.hiddenDelegate respondsToSelector:@selector(textviewDidHiddeFromSuperviewNeedToRefresh:)]) {
        [self.hiddenDelegate textviewDidHiddeFromSuperviewNeedToRefresh:NO];
    }

}
#pragma mark ==============UIKeyboardNotification=============
-(void)keyboardWillShow:(NSNotification *)aNotification{
        //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyBoardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        NSLog(@"before=====%@,height====%f", NSStringFromCGRect(self.frame),keyBoardHeight);
        self.contentView.frame = CGRectMake(0, self.frame.size.height -keyBoardHeight- self.originalHeight, self.frame.size.width, self.originalHeight);
        NSLog(@"after=====%@", NSStringFromCGRect(self.frame));

    }];
}
-(void)keyboardWillDisappear:(NSNotification *)aNotification{
        //键盘消失时 隐藏工具栏
    [UIView animateWithDuration:0.25 animations:^{

        self.contentView.frame = CGRectMake(0, self.originalY, self.frame.size.width, self.originalHeight);
        NSLog(@"keyboardHidden=====%@", NSStringFromCGRect(self.frame));

    }];

}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    CGSize siz = [textView.text suggestedSizeWithFont:[UIFont systemFontOfSize:14] width:self.textview.frame.size.width];
  //  NSLog(@"[-][-][-][-][-],stringsize:[%f] textfiled:[%f],bar:[%f]",siz.height,textView.height,self.height);

    CGRect barFrame = self.contentView.frame;
    CGFloat offsetY = 10;
        //    barFrame.size.height - textFrame.size.height;
    if (siz.height<35) {
        siz.height = 35;
    }
    if (siz.height>80) {
        siz.height = 80;
    }

    barFrame.origin.y -= (siz.height+offsetY - barFrame.size.height);
    barFrame.size.height = siz.height+offsetY;

    self.contentView.frame = barFrame;
    _finalFrame = barFrame;
   // NSLog(@"[-][-][-][-][-]textfiled:[%f],bar:[%f]",self.textview.height,self.height);
    return YES;
}


-(void)replyAction:(UIButton *)btn {
    NSLog(@"输入文字:%@", self.textview.text);
    _replyTxt = [self.textview.text trim];
    if (!_replyTxt || [_replyTxt isEmpty]) {
      //  [self showMBProgressWithString:@"回复不能为空呦~"];
        return;
    }

    [self tapInBackView:nil];
    self.replyTxt = nil;
    self.textview.text = nil;

   // weakself(self);
  //  NSDictionary *dic ;
    if (ISNullOrEmpty(_replyId)) { //回复的是问题
//        dic =@{@"api_name":@"reply_question_by_user",@"question_id":ISNIL(_qstId),@"answer_text":ISNIL(_replyTxt),kURLToken};
    }else{  //回复的是楼层
//        dic =@{@"api_name":@"reply_question_by_user",@"question_user_id":ISNIL(_replyId),@"question_id":ISNIL(_qstId),@"answer_text":ISNIL(_replyTxt),kURLToken};
    }

    if(!ISNullOrEmpty(_art_id)){
//        dic = @{@"api_name":@"add_consultant_article_comments",@"art_id":ISNIL(_art_id),@"content":ISNIL(_replyTxt),kURLToken};
    }

//    [FYNetManager POST:NewUrlEntranceStr parameters:dic complationHandle:^(id responseObject, NSError *error) {
//        [weakSelf hiddenMBProgressView];
//        if ([responseObject isSuccess]) {
//
//            [weakSelf showSuccessWithStr:@"发布成功"];
//                //代理传值
//            weakSelf.replyTxt = nil;
//            weakSelf.textview.text = nil;
//            if ([weakSelf.hiddenDelegate respondsToSelector:@selector(textviewDidHiddeFromSuperviewNeedToRefresh:)]) {
//                [weakSelf.hiddenDelegate textviewDidHiddeFromSuperviewNeedToRefresh:YES];
//            }
//        }
//    }];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
