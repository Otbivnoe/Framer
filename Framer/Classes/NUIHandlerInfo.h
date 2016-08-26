//
//  NUIHandlerInfo.h
//  Pods
//
//  Created by Nikita on 06/08/16.
//
//

#import <Foundation/Foundation.h>
#import "UIView+NUIAdditions.h"

@interface NUIHandlerInfo : NSObject

@property (nonatomic, readonly) NUIRelationType handlerType;

@property (nonatomic, nullable, readonly) id first;
@property (nonatomic, nullable, readonly) id second;
@property (nonatomic, nullable, readonly) id third;
@property (nonatomic, nullable, readonly) id fourth;

+ (nullable instancetype)infoWithType:(NUIRelationType)type parameters:(nullable id)first, ... NS_REQUIRES_NIL_TERMINATION;

@end


@interface NUIHandlerInfo (ObjectSubscripting)

- (nullable id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
