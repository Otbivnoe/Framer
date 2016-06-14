//
//  NUIFramer.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIFramer.h"
#import "NUIHandler.h"
#import "NUIAdditionalConfigurateFactory.h"

@interface NUIFramer ()

@property (nonatomic) NSMutableArray <NUIHandler *> *handlers;

@end

@implementation NUIFramer

#pragma mark - Initialize

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _handlers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Configurate

#pragma mark Top priority 

- (NUIFramer *(^)(CGFloat))left {
    
    return ^id(CGFloat x) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            frame.origin.x = x;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (NUIFramer *(^)(CGFloat))top {
    
    return ^id(CGFloat y) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            frame.origin.y = y;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

#pragma mark Middle priority

- (NUIFramer* (^)(CGFloat))width {
    
    return ^id(CGFloat width) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            frame.size.width = width;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (NUIFramer* (^)(CGFloat))height {
    
    return ^id(CGFloat height) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            frame.size.height = height;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (NUIFramer *(^)(CGFloat))bottom {
    
    return ^id(CGFloat bottom) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            CGFloat height = CGRectGetHeight(strongSelf.view.superview.bounds) - (CGRectGetMinY(strongSelf.view.frame) + bottom);
            frame.size.height = height;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (NUIFramer *(^)(UIEdgeInsets))insets {
    
    return ^id(UIEdgeInsets insets) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat width = CGRectGetWidth(strongSelf.view.superview.bounds) - (insets.left + insets.right);
            CGFloat height = CGRectGetHeight(strongSelf.view.superview.bounds) - (insets.top + insets.bottom);
            CGRect frame = CGRectMake(insets.left, insets.top, width, height);
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))left_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat x =  CGRectGetMaxX(view.frame) + inset;
            CGRect frame = strongSelf.view.frame;
            frame.origin.x = x;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))right_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat x =  CGRectGetMinX(view.frame) - inset - CGRectGetWidth(strongSelf.view.bounds);
            CGRect frame = strongSelf.view.frame;
            frame.origin.x = x;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

#pragma mark Low priority

- (NUIFramer *(^)(CGFloat))right {
    
    return ^id(CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.view.frame;
            CGFloat width = CGRectGetWidth(strongSelf.view.superview.bounds) - (CGRectGetMinX(strongSelf.view.frame) + inset);
            frame.size.width = width;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))top_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat y =  CGRectGetMaxY(view.frame) + inset;
            CGRect frame = strongSelf.view.frame;
            frame.origin.y = y;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))bottom_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat y =  CGRectGetMinY(view.frame) - inset - CGRectGetHeight(strongSelf.view.frame);
            CGRect frame = strongSelf.view.frame;
            frame.origin.y = y;
            strongSelf.view.frame = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))centerX_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGPoint center = CGPointMake(view.center.x, strongSelf.view.center.y);
            center.x += inset;
            strongSelf.view.center = center;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))centerY_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGPoint center = CGPointMake(strongSelf.view.center.x, view.center.y);
            center.y += inset;
            strongSelf.view.center = center;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(CGFloat inset))super_centerX {
    
    return ^id(CGFloat inset) {
        return self.centerX_to(self.view.superview, inset);
    };
}

- (NUIFramer *(^)(CGFloat inset))super_centerY {
    
    return ^id(CGFloat inset) {
        return self.centerY_to(self.view.superview, inset);
    };
}

#pragma mark - Configurate methods

- (void)configurateOrderHandlers {
    
    [self.handlers sortUsingComparator:^NSComparisonResult(NUIHandler * _Nonnull handler1, NUIHandler *handler2) {
        if (handler1.priority > handler2.priority) {
            return NSOrderedAscending;
        }
        return (handler1.priority == handler2.priority) ? NSOrderedSame : NSOrderedDescending;
    }];
}

- (void)configurateFrames {

    [[NUIAdditionalConfigurateFactory additionalConfigurates] enumerateObjectsUsingBlock:^(id<NUIConfigurateProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.view isKindOfClass:obj.class]) {
            [obj additionalConfigurateForFramer:self];
        }
    }];
    
    [self.handlers enumerateObjectsUsingBlock:^(NUIHandler * _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
        handler.handlerBlock();
    }];
}

@end
