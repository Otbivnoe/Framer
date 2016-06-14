//
//  NUIHandler.m
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIHandler.h"

@implementation NUIHandler

+ (instancetype)handlerWithBlock:(dispatch_block_t)handlerBlock priority:(NUIHandlerPriority)priority {
    
    NUIHandler *handler = [[NUIHandler alloc] init];
    handler.handlerBlock = handlerBlock;
    handler.priority = priority;
    return handler;
}

@end
