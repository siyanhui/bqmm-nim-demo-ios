//
//  NIMTextContentConfig.m
//  NIMKit
//
//  Created by amao on 9/15/15.
//  Copyright (c) 2015 NetEase. All rights reserved.
//

#import "NIMTextContentConfig.h"
#import "NIMAttributedLabel+NIMKit.h"

//BQMM集成

#import <BQMM/BQMM.h>
#import "MMTextParser.h"
#import "MMTextView.h"

@interface NIMTextContentConfig()

//BQMM集成
//@property (nonatomic,strong) NIMAttributedLabel *label;
@property (nonatomic, strong) MMTextView *textMessageView;

@end


@implementation NIMTextContentConfig

- (CGSize)contentSize:(CGFloat)cellWidth
{
    //BQMM集成
    NSDictionary *ext = self.message.remoteExt;
    if ([ext[@"txt_msgType"] isEqualToString:@"facetype"]) {
        return CGSizeMake(140, 140);
    }else{
        //        NSString *text = self.message.text;
        //        [self.label nim_setText:text];
        
        CGFloat msgBubbleMaxWidth    = (cellWidth - 130);
        CGFloat bubbleLeftToContent  = 14;
        CGFloat contentRightToBubble = 14;
        CGFloat msgContentMaxWidth = (msgBubbleMaxWidth - contentRightToBubble - bubbleLeftToContent);
        //        return [self.label sizeThatFits:CGSizeMake(msgContentMaxWidth, CGFLOAT_MAX)];
        
        
        CGSize size = CGSizeZero;
        if (ext[@"msg_data"] != nil) {
            size = [MMTextParser sizeForMMTextWithExtData:ext[@"msg_data"] font:[UIFont systemFontOfSize:NIMKit_Message_Font_Size] maximumTextWidth:msgContentMaxWidth];
        }else{
            size = [MMTextParser sizeForTextWithText:self.message.text font:[UIFont systemFontOfSize:NIMKit_Message_Font_Size] maximumTextWidth:msgContentMaxWidth];
        }
        
        return size;
    }
}

- (NSString *)cellContent
{
    //BQMM集成
    NSDictionary *ext = self.message.remoteExt;
    if ([ext[@"txt_msgType"] isEqualToString:@"facetype"]) {
        return @"NIMSessionEmojiContentView";
    }else{
        return @"NIMSessionTextContentView";
    }
    
}

- (UIEdgeInsets)contentViewInsets
{
    return self.message.isOutgoingMsg ? UIEdgeInsetsMake(11,11,9,15) : UIEdgeInsetsMake(11,15,9,9);
}


//- (NIMAttributedLabel *)label
//{
//    if (_label) {
//        return _label;
//    }
//    _label = [[NIMAttributedLabel alloc] initWithFrame:CGRectZero];
//    _label.font = [UIFont systemFontOfSize:NIMKit_Message_Font_Size];
//    return _label;
//}

@end
