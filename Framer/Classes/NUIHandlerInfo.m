//
//  NUIHandlerInfo.m
//  Pods
//
//  Created by Nikita on 06/08/16.
//
//

#import "NUIHandlerInfo.h"

@interface NUIHandlerInfo ()

@property (nonatomic) NSArray<__kindof NSObject *> *parameters;
@property (nonatomic) NUIRelationType handlerType;

@end

@implementation NUIHandlerInfo

+ (instancetype)infoWithType:(NUIRelationType)type parameters:(id)first, ... NS_REQUIRES_NIL_TERMINATION {
    
    NUIHandlerInfo *info = [[NUIHandlerInfo alloc] init];
    info.handlerType = type;
    
    if (first) {
        va_list argumentList;
        
        NSMutableArray *parameters = [[NSMutableArray alloc] init];
        
        va_start(argumentList, first);
        for (id currentObject = first; currentObject != nil; currentObject = va_arg(argumentList, id)) {
            [parameters addObject:currentObject];
        }
        
        va_end(argumentList);
        
        info.parameters = [parameters copy];
    }
    
    return info;
}

- (id)first {
    return self[0];
}

- (id)second {
    return self[1];
}

- (id)third {
    return self[2];
}

- (id)fourth {
    return self[3];
}

@end

@implementation NUIHandlerInfo (ObjectSubscripting)

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.parameters.count) {
        return nil;
    }
    return self.parameters[idx];
}

@end