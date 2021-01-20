//
//  SGNALUnit+Internal.h
//  SGPlayer
//
//  Created by Songming on 2021/1/20.
//  Copyright © 2021 single. All rights reserved.
//

#ifndef SGNALUnit_Internal_h
#define SGNALUnit_Internal_h

#import "SGNALUnit.h"
#include <libavcodec/avcodec.h>

@interface SGNALUnit ()

+ (instancetype)unitFromPacket:(AVPacket *)packet;

@end

#endif /* SGNALUnit_Internal_h */
