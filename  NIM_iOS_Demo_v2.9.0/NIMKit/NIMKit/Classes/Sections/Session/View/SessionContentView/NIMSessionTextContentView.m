//
//  NIMSessionTextContentView.m
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NIMSessionTextContentView.h"
#import "NIMAttributedLabel+NIMKit.h"
#import "NIMMessageModel.h"
#import "NIMGlobalMacro.h"

NSString *const NIMTextMessageLabelLinkData = @"NIMTextMessageLabelLinkData";

@interface NIMSessionTextContentView()<NIMAttributedLabelDelegate>

@end

@implementation NIMSessionTextContentView

-(instancetype)initSessionMessageContentView
{
    if (self = [super initSessionMessageContentView]) {
//        _textLabel = [[NIMAttributedLabel alloc] initWithFrame:CGRectZero];
//        _textLabel.delegate = self;
//        _textLabel.numberOfLines = 0;
//        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        _textLabel.font = [UIFont systemFontOfSize:NIMKit_Message_Font_Size];
//        _textLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:_textLabel];
        
        //BQMM集成
        _textMessageView = [[MMTextView alloc] init];
        _textMessageView.backgroundColor = [UIColor clearColor];
        _textMessageView.textContainerInset = UIEdgeInsetsZero;
        _textMessageView.mmTextColor = [UIColor blackColor];
        _textMessageView.mmFont = [UIFont systemFontOfSize:NIMKit_Message_Font_Size];
        _textMessageView.editable = false;
        _textMessageView.selectable = false;
        _textMessageView.scrollEnabled = false;
        _textMessageView.clickActionDelegate = self;
        [self addSubview:_textMessageView];
    }
    return self;
}

- (void)refresh:(NIMMessageModel *)data{
    [super refresh:data];
    //BQMM集成
//    NSString *text = self.model.message.text;
//    [_textLabel nim_setText:text];
    if (!self.model.message.isOutgoingMsg) {
        _textMessageView.mmTextColor = [UIColor blackColor];
    }else{
        _textMessageView.mmTextColor = [UIColor whiteColor];
    }
    
    NSDictionary *extDic = data.message.remoteExt;
    if(extDic[@"msg_data"] != nil) {
        [_textMessageView setMmTextData:extDic[@"msg_data"]];
    }else{
        _textMessageView.text = data.message.text;
        [_textMessageView setURLAttributes];
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets contentInsets = self.model.contentViewInsets;
    CGSize contentsize         = self.model.contentSize;
    CGRect labelFrame = CGRectMake(contentInsets.left, contentInsets.top, contentsize.width, contentsize.height);
    //BQMM集成
//    self.textLabel.frame = labelFrame;
    
    _textMessageView.frame = labelFrame;
}

//BQMM集成
- (void)onTouchUpInside:(id)sender
{
    NSLog(@"点击了文字消息");
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

//BQMM集成
#pragma mark MMTextViewDelegate
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    NSString *number = [@"tel://" stringByAppendingString:phoneNumber];
    
    NIMKitEvent *event = [[NIMKitEvent alloc] init];
    event.eventName = NIMKitEventNameTapLabelLink;
    event.messageModel = self.model;
    event.data = number;
    [self.delegate onCatchEvent:event];
}

- (void)mmTextView:(MMTextView *)textView didSelectLinkWithURL:(NSURL *)url {
    NSString *urlString=[url absoluteString];
    if (![urlString hasPrefix:@"http"]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    NIMKitEvent *event = [[NIMKitEvent alloc] init];
    event.eventName = NIMKitEventNameTapLabelLink;
    event.messageModel = self.model;
    event.data = urlString;
    [self.delegate onCatchEvent:event];
}

@end
