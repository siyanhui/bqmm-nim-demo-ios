//
//  NIMTextContentConfig.m
//  NIMKit
//
//  Created by amao on 9/15/15.
//  Copyright (c) 2015 NetEase. All rights reserved.
//

#import "NIMTextContentConfig.h"
#import "M80AttributedLabel+NIMKit.h"
#import "NIMKit.h"

@interface NIMTextContentConfig()

@property (nonatomic,strong) M80AttributedLabel *label;

@end


@implementation NIMTextContentConfig

//BQMM集成
- (CGSize)contentSize:(CGFloat)cellWidth message:(NIMMessage *)message
{
    //BQMM集成
    NSDictionary *ext = message.remoteExt;
    if ([ext[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE]) {
        return CGSizeMake(140, 140);
    }else if([ext[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_WEB_TYPE]) {
        
        NSDictionary *msgData = ext[TEXT_MESG_DATA];
        float height = [msgData[WEBSTICKER_HEIGHT] floatValue];
        float width = [msgData[WEBSTICKER_WIDTH] floatValue];
        //宽最大200 高最大 150
        if (width > 200) {
            height = 200.0 / width * height;
            width = 200;
        }else if(height > 150) {
            width = 150.0 / height * width;
            height = 150;
        }
        return CGSizeMake(width, height);
    }else{
        NSString *text = message.text;
        [self.label nim_setText:text];
        
        CGFloat msgBubbleMaxWidth    = (cellWidth - 130);
        CGFloat bubbleLeftToContent  = 14;
        CGFloat contentRightToBubble = 14;
        CGFloat msgContentMaxWidth = (msgBubbleMaxWidth - contentRightToBubble - bubbleLeftToContent);
        return [self.label sizeThatFits:CGSizeMake(msgContentMaxWidth, CGFLOAT_MAX)];
    }
}

//BQMM集成
- (NSString *)cellContent:(NIMMessage *)message
{
    //BQMM集成
    NSDictionary *ext = message.remoteExt;
    if ([ext[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE] || [ext[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_WEB_TYPE]) {
        return @"NIMSessionEmojiContentView";
    }else{
        return @"NIMSessionTextContentView";
    }
}

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message
{
    return [[NIMKit sharedKit].config setting:message].contentInsets;
}



#pragma mark - Private
- (M80AttributedLabel *)label
{
    if (_label) {
        return _label;
    }
    _label = [[M80AttributedLabel alloc] initWithFrame:CGRectZero];
    _label.font = [UIFont systemFontOfSize:NIMKit_Message_Font_Size];
    return _label;
}

@end
