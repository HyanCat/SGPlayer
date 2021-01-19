//
//  SGNALUnit.m
//  SGPlayer
//
//  Created by Songming on 2021/1/19.
//  Copyright © 2021 single. All rights reserved.
//

#import "SGNALUnit.h"

static inline int ff_get_nal_units_type(const uint8_t * const data) {
    return data[4] & 0x1f;
}
static inline int ff_get_nal_sei_type(const uint8_t * const data) {
    return data[5] & 0x1f;
}

static uint32_t bytesToInt(uint8_t* src) {
    uint32_t value;
    value = (uint32_t)((src[0] & 0xFF)<<24|(src[1]&0xFF)<<16|(src[2]&0xFF)<<8|(src[3]&0xFF));
    return value;
}

@implementation SGNALSEI
@end

@interface SGNALUnit ()
@property (nonatomic, assign) AVPacket *packet;
@end

NSInteger const kSGNALUnitSEIUUIDLength = 16;
NSInteger const KSGNALUnitSEIPayloadType = 5;

@implementation SGNALUnit

+ (instancetype)unitFromPacket:(AVPacket *)packet {
    SGNALUnit *unit = [[SGNALUnit alloc] init];
    unit.packet = packet;
    [unit parse];
    return unit;
}

- (void)parse {
    AVPacket *pkt = self.packet;
    if (pkt->data && pkt->size >= 5) {
        int offset = 0;
        while (offset >= 0 && offset + 5 <= pkt->size) {
            uint8_t *nalPtr = pkt->data+offset;
            int state = ff_get_nal_units_type(nalPtr);

            if (state == NAL_UNIT_TYPE_SEI) {
                int type = ff_get_nal_sei_type(nalPtr);
                if (type == KSGNALUnitSEIPayloadType) {
                    uint8_t *uuidPtr = nalPtr+7;
                    NSData *uuidData = [NSData dataWithBytes:uuidPtr length:kSGNALUnitSEIUUIDLength];
                    int payloadLength = nalPtr[6];
                    
                    int contentLength = payloadLength-kSGNALUnitSEIUUIDLength;
                    uint8_t *contentPtr = nalPtr+7+kSGNALUnitSEIUUIDLength;
                    NSData *seiData = [NSData dataWithBytes:contentPtr length:contentLength];
                    SGNALSEI *sei = [[SGNALSEI alloc] init];
                    sei.uuid = uuidData;
                    sei.data = seiData;
                    _SEI = sei;
                    return;
                }
                
            }
            offset += (bytesToInt(nalPtr) + 4);
        }
    }
}

@end
