//
//  SGAudioPlaybackOutput.h
//  SGPlayer
//
//  Created by Single on 2018/1/19.
//  Copyright © 2018年 single. All rights reserved.
//

#import "SGOutput.h"
#import "SGPlaybackTimeSync.h"

@interface SGAudioPlaybackOutput : NSObject <SGOutput>

@property (nonatomic, strong) SGPlaybackTimeSync * timeSync;
@property (nonatomic, assign) float volume;             // Default is 1.
@property (nonatomic, assign) CMTime rate;              // Default is (1, 1).
@property (nonatomic, assign) CMTime deviceDelay;       // Default is (1, 20).

@end
