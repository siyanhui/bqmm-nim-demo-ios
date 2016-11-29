//
//  NTESChatroomTextContentConfig.m
//  NIM
//
//  Created by chris on 16/1/13.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NTESChatroomTextContentConfig.h"
#import "NIMAttributedLabel+NIMKit.h"
#import "NIMGlobalMacro.h"

//BQMM集成
#import "MMTextParser.h"
#import "MMTextView.h"

@interface NTESChatroomTextContentConfig()

//BQMM集成
//@property (nonatomic, strong) NIMAttributedLabel *label;
@property (nonatomic, strong) MMTextView *textMessageView;

@end

@implementation NTESChatroomTextContentConfig

- (CGSize)contentSize:(CGFloat)cellWidth
{
    
    //BQMM集成
    NSDictionary *ext = self.message.remoteExt;
    if ([ext[@"txt_msgType"] isEqualToString:@"facetype"]) {
        return CGSizeMake(100, 100);
    }else{
        //        NSString *text = self.message.text;
        //        [self.label nim_setText:text];
        CGFloat msgBubbleMaxWidth    = (cellWidth - 130);
        CGFloat bubbleLeftToContent  = 15;
        CGFloat contentRightToBubble = 0;
        CGFloat msgContentMaxWidth = (msgBubbleMaxWidth - contentRightToBubble - bubbleLeftToContent);
        //        return [self.label sizeThatFits:CGSizeMake(msgContentMaxWidth, CGFLOAT_MAX)];
        
        CGSize size = CGSizeZero;
        if (ext[@"msg_data"] != nil) {
            size = [MMTextParser sizeForMMTextWithExtData:ext[@"msg_data"] font:[UIFont systemFontOfSize:Chatroom_Message_Font_Size] maximumTextWidth:msgContentMaxWidth];
        }else{
            size = [MMTextParser sizeForTextWithText:self.message.text font:[UIFont systemFontOfSize:Chatroom_Message_Font_Size] maximumTextWidth:msgContentMaxWidth];
        }
        
        return size;
    }
}

- (NSString *)cellContent
{
    //BQMM集成
    NSDictionary *ext = self.message.remoteExt;
    if ([ext[@"txt_msgType"] isEqualToString:@"facetype"]) {
        return @"NTESChatroomEmojiContentView";
    }else{
        return @"NTESChatroomTextContentView";
    }
    
}

- (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(20,15,10,0);
}

//- (NIMAttributedLabel *)label
//{
//    if (!_label) {
//        _label = [[NIMAttributedLabel alloc] initWithFrame:CGRectZero];
//        _label.font = [UIFont systemFontOfSize:Chatroom_Message_Font_Size];
//    }
//    return _label;
//}

@end
