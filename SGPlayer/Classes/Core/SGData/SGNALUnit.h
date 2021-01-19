//
//  SGNALUnit.h
//  SGPlayer
//
//  Created by Songming on 2021/1/19.
//  Copyright © 2021 single. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libavcodec/avcodec.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NAL_UNIT_TYPE) {
    NAL_UNIT_TYPE_SLICE           = 1,
    NAL_UNIT_TYPE_DPA             = 2,
    NAL_UNIT_TYPE_DPB             = 3,
    NAL_UNIT_TYPE_DPC             = 4,
    NAL_UNIT_TYPE_IDR_SLICE       = 5,
    NAL_UNIT_TYPE_SEI             = 6,
    NAL_UNIT_TYPE_SPS             = 7,
    NAL_UNIT_TYPE_PPS             = 8,
    NAL_UNIT_TYPE_AUD             = 9,
    NAL_UNIT_TYPE_END_SEQUENCE    = 10,
    NAL_UNIT_TYPE_END_STREAM      = 11,
    NAL_UNIT_TYPE_FILLER_DATA     = 12,
    NAL_UNIT_TYPE_SPS_EXT         = 13,
    NAL_UNIT_TYPE_AUXILIARY_SLICE = 19,
    NAL_UNIT_TYPE_FF_IGNORE       = 0xff0f001,
};

@interface SGNALSEI : NSObject
@property (nonatomic, strong, nullable) NSData *uuid;
@property (nonatomic, strong, nullable) NSData *data;
@end

@interface SGNALUnit : NSObject

@property (nonatomic, assign, readonly) NAL_UNIT_TYPE unitType;
@property (nonatomic, strong, readonly, nullable) SGNALSEI *SEI;

+ (instancetype)unitFromPacket:(AVPacket *)packet;

@end

NS_ASSUME_NONNULL_END
