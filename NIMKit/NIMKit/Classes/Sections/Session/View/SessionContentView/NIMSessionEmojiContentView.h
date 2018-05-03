//
//  NIMSessionEmojiContentView.h
//  NIMKit
//
//  Created by isan on 10/10/2016.
//  Copyright © 2016 NetEase. All rights reserved.
//
#import <BQMM/BQMM.h>
#import "NIMSessionMessageContentView.h"

@interface NIMSessionEmojiContentView : NIMSessionMessageContentView

//BQMM集成
@property (nonatomic,strong,readonly) MMImageView * imageView;

@end
