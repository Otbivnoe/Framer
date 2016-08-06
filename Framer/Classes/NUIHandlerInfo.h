//
//  NUIHandlerInfo.h
//  Pods
//
//  Created by Nikita on 06/08/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NUIHandlerType) {
    NUIHandlerTypeBottom,
    NUIHandlerTypeTop,
    NUIHandlerTypeLeft,
    NUIHandlerTypeRight,
    NUIHandlerTypeWidth,
    NUIHandlerTypeHeight
};

@interface NUIHandlerInfo : NSObject

@property (nonatomic, readonly) NUIHandlerType handlerType;

@property (nonatomic, nullable, readonly) id first;
@property (nonatomic, nullable, readonly) id second;
@property (nonatomic, nullable, readonly) id third;
@property (nonatomic, nullable, readonly) id fourth;

+ (instancetype)infoWithType:(NUIHandlerType)type parameters:(id)first, ... NS_REQUIRES_NIL_TERMINATION;

@end


@interface NUIHandlerInfo (ObjectSubscripting)

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end