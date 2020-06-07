//
//  ReplyView.h
//  Soulmate
//
//  Created by Hengzhi Wang on 2018/9/12.
//  Copyright © 2018年 guiguiTechnical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPlaceholderTextView.h"

@protocol  TextViewInputToolHiddeDelegate<NSObject>
-(void)textviewDidHiddeFromSuperviewNeedToRefresh:(BOOL)refresh;
@end

@interface ReplyView : UIView<UITextViewDelegate>
@property(nonatomic,strong) NSString *replyTxt;
@property(nonatomic,strong) NSString *qstId; //问题
@property(nonatomic,strong) NSString *replyId; //楼层
@property(nonatomic,strong) NSString *art_id;//文章评论
@property(nonatomic,strong) BRPlaceholderTextView  * textview;
@property(nonatomic,assign) id <TextViewInputToolHiddeDelegate> hiddenDelegate;


//内部用
@property(nonatomic,strong) UIView * contentView;
@property(nonatomic,assign) CGFloat originalY;
@property(nonatomic,assign) CGFloat originalHeight;
@property(nonatomic,strong) UIButton *sendBtn;
@property(nonatomic,assign) CGRect finalFrame;

@end
