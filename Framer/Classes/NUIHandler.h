//
//  NUIHandler.h
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NUIHandlerPriority) {
    NUIHandlerPriorityLow,
    NUIHandlerPriorityMiddle,
    NUIHandlerPriorityHigh,
};

@interface NUIHandler : NSObject

+ (instancetype)handlerWithBlock:(dispatch_block_t)handlerBlock priority:(NUIHandlerPriority)priority;

@property (nonatomic) dispatch_block_t handlerBlock;
@property (nonatomic) NUIHandlerPriority priority;

@end
