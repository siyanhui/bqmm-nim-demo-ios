//
//  NTESChatroomEmojiContentView.h
//  NIM
//
//  Created by isan on 11/10/2016.
//  Copyright © 2016 Netease. All rights reserved.
//

#import "NIMSessionMessageContentView.h"
#import <BQMM/BQMM.h>
@interface NTESChatroomEmojiContentView : NIMSessionMessageContentView

//BQMM集成
@property (nonatomic,strong,readonly) MMImageView * imageView;

@end
