//
//  NIMSessionTextContentView.h
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NIMSessionMessageContentView.h"
//BQMM集成
#import "MMTextView.h"
@class NIMAttributedLabel;

@interface NIMSessionTextContentView : NIMSessionMessageContentView<MMTextViewDelegate>

@property (nonatomic, strong) NIMAttributedLabel *textLabel;
@property (nonatomic, strong) MMTextView *textMessageView;

@end
