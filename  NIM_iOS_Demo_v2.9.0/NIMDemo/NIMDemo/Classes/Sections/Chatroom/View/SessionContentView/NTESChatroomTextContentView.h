//
//  NTESChatroomTextContentView.h
//  NIM
//
//  Created by chris on 16/1/13.
//  Copyright © 2016年 Netease. All rights reserved.
//


#import "NIMSessionMessageContentView.h"

//BQMM集成
#import "MMTextView.h"

@class NIMAttributedLabel;

@interface NTESChatroomTextContentView : NIMSessionMessageContentView

//BQMM集成
//@property (nonatomic, strong) NIMAttributedLabel *textLabel;
@property (nonatomic, strong) MMTextView *textMessageView;

@end
