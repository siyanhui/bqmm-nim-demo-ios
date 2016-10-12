//
//  NTESChatroomTextContentView.m
//  NIM
//
//  Created by chris on 16/1/13.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NTESChatroomTextContentView.h"
#import "NIMAttributedLabel+NIMKit.h"
#import "NIMMessageModel.h"
#import "NIMGlobalMacro.h"

@interface NTESChatroomTextContentView()<NIMAttributedLabelDelegate>

@end

@implementation NTESChatroomTextContentView

- (instancetype)initSessionMessageContentView
{
    if (self = [super initSessionMessageContentView]) {
        //BQMM集成
        _textMessageView = [[MMTextView alloc] init];
        _textMessageView.backgroundColor = [UIColor clearColor];
        _textMessageView.textContainerInset = UIEdgeInsetsZero;
        _textMessageView.mmTextColor = [UIColor blackColor];
        _textMessageView.mmFont = [UIFont systemFontOfSize:Chatroom_Message_Font_Size];
        _textMessageView.editable = false;
        _textMessageView.selectable = false;
        _textMessageView.scrollEnabled = false;
        _textMessageView.clickActionDelegate = self;
        [self addSubview:_textMessageView];
        
        
    }
    return self;
}

- (void)refresh:(NIMMessageModel *)model{
    [super refresh:model];
    //BQMM集成
    NSDictionary *extDic = model.message.remoteExt;
    if(extDic[@"msg_data"] != nil) {
        [_textMessageView setMmTextData:extDic[@"msg_data"]];
    }else{
        _textMessageView.text = model.message.text;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets contentInsets = self.model.contentViewInsets;
    CGSize contentsize         = self.model.contentSize;
    CGRect labelFrame = CGRectMake(contentInsets.left, contentInsets.top, contentsize.width, contentsize.height);
    //BQMM集成
    _textMessageView.frame = labelFrame;
}


- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    return nil;
}

#pragma mark - NIMAttributedLabelDelegate
- (void)nimAttributedLabel:(NIMAttributedLabel *)label
             clickedOnLink:(id)linkData{
    NIMKitEvent *event = [[NIMKitEvent alloc] init];
    event.eventName = NIMKitEventNameTapLabelLink;
    event.messageModel = self.model;
    event.data = linkData;
    [self.delegate onCatchEvent:event];
}


@end
