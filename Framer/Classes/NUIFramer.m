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

#import "UIView+NUIAdditions.h"

typedef NS_ENUM(NSInteger, NUIValueType) {
    NUIValueTypeWidth,
    NUIValueTypeHeight
};

@interface NUIFramer ()

@property (nonatomic, getter=isTopFrameInstalled) BOOL topFrameInstalled;
@property (nonatomic, getter=isLeftFrameInstalled) BOOL leftFrameInstalled;

@property (nonatomic, nonnull) NSMutableArray <NUIHandler *> *handlers;
@property (nonatomic) CGRect newRect;

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

#pragma mark - Configurate methods

+ (void)configurateView:(UIView *)view withInstallerBlock:(void(^)(NUIFramer *framer))installerBlock {
    
    NUIFramer *framer = [[NUIFramer alloc] init];
    framer.view = view;
    
    [framer startConfigurate];
    
    if (installerBlock) {
        installerBlock(framer);
    }
    [framer configurateFrames];
}


- (void)startConfigurate {
    
    self.newRect = self.view.frame;
}

- (void)endConfigurate {
    
    self.view.frame = self.newRect;
}

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
    [self configurateOrderHandlers];
    
    [self.handlers enumerateObjectsUsingBlock:^(NUIHandler * _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
        handler.handlerBlock();
    }];
    [self endConfigurate];
}

#pragma mark - Framer methods

- (NUIFramer *)and {
    return self;
}

#pragma mark - Top priority

#pragma mark Width / Height relations

- (NUIFramer* (^)(CGFloat))width {
    
    return ^id(CGFloat width) {
        [self setHighPriorityValue:width withType:NUIValueTypeWidth];
        return self;
    };
}

- (NUIFramer* (^)(CGFloat))height {
    
    return ^id(CGFloat height) {
        [self setHighPriorityValue:height withType:NUIValueTypeHeight];
        return self;
    };
}

- (void)setHighPriorityValue:(CGFloat)value withType:(NUIValueType)type {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_block_t handler = ^ {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGRect frame = [strongSelf setFrameValue:value type:type];
        strongSelf.newRect = frame;
    };
    [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
}

- (CGRect)setFrameValue:(CGFloat)value type:(NUIValueType)type {
    
    CGRect frame = self.newRect;
    switch (type) {
        case NUIValueTypeWidth:
            frame.size.width = value;
            break;
        case NUIValueTypeHeight:
            frame.size.height = value;
            break;
    }
    return frame;
}

#pragma mark Left relations

- (NUIFramer *(^)(CGFloat))left {

    return ^id(CGFloat inset) {
        return self.left_to(self.view.superview.left, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))left_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat x =  [strongSelf leftRelationXForView:view withInset:inset relationType:relationType];
            CGRect frame = strongSelf.newRect;
            frame.origin.x = x;
            strongSelf.newRect = frame;
            strongSelf.leftFrameInstalled = YES;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (CGFloat)leftRelationXForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat x = 0;
    switch (relationType) {
        case NUIRelationTypeLeft:     x = CGRectGetMinX(convertedRect); break;
        case NUIRelationTypeRight:    x = CGRectGetMaxX(convertedRect); break;
        case NUIRelationTypeCenterX:  x = CGRectGetMidX(convertedRect); break;
        default:break;
    }
    return x + inset;
}

#pragma mark Top relations

- (NUIFramer *(^)(CGFloat))top {
    
    return ^id(CGFloat inset) {
        return self.top_to(self.view.superview.top, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))top_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat y =  [strongSelf topRelationYForView:view withInset:inset relationType:relationType];
            CGRect frame = strongSelf.newRect;
            frame.origin.y = y;
            strongSelf.newRect = frame;
            strongSelf.topFrameInstalled = YES;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (CGFloat)topRelationYForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat y = 0;
    switch (relationType) {
        case NUIRelationTypeTop:      y = CGRectGetMinY(convertedRect); break;
        case NUIRelationTypeBottom:   y = CGRectGetMaxY(convertedRect); break;
        case NUIRelationTypeCenterY:  y = CGRectGetMidY(convertedRect); break;
        default:break;
    }
    return y + inset;
}

#pragma mark Container

- (NUIFramer *(^)())container {
    
    return ^id() {
        CGRect frame = CGRectZero;
        for (UIView *subview in [self.view subviews]) {
            frame = CGRectUnion(frame, subview.frame);
        }

        [self setHighPriorityValue:CGRectGetWidth(frame) withType:NUIValueTypeWidth];
        [self setHighPriorityValue:CGRectGetHeight(frame) withType:NUIValueTypeHeight];
        return self;
    };
}

#pragma mark - Middle priority

- (NUIFramer *(^)(UIEdgeInsets))edges {
    
    return ^id(UIEdgeInsets insets) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat width = CGRectGetWidth(strongSelf.view.superview.bounds) - (insets.left + insets.right);
            CGFloat height = CGRectGetHeight(strongSelf.view.superview.bounds) - (insets.top + insets.bottom);
            CGRect frame = CGRectMake(insets.left, insets.top, width, height);
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

#pragma mark Bottom relations

- (NUIFramer *(^)(CGFloat))bottom {

    return ^id(CGFloat inset) {
        return self.bottom_to(self.view.superview.bottom, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))bottom_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            if (!strongSelf.isTopFrameInstalled) {
                CGFloat y =  [strongSelf bottomRelationYForView:view withInset:inset relationType:relationType];
                frame.origin.y = y;
            } else {
                frame.size.height = [strongSelf bottomRelationHeightForView:view withInset:inset relationType:relationType];
            }
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (CGFloat)bottomRelationHeightForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat height = 0;
    switch (relationType) {
        case NUIRelationTypeTop:      height = fabs(CGRectGetMinY(self.newRect) - CGRectGetMinY(convertedRect)); break;
        case NUIRelationTypeBottom:   height = fabs(CGRectGetMinY(self.newRect) - CGRectGetMaxY(convertedRect)); break;
        case NUIRelationTypeCenterY:  height = fabs(CGRectGetMinY(self.newRect) - CGRectGetMidY(convertedRect)); break;
        default:break;
    }
    return height - inset;
}

- (CGFloat)bottomRelationYForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat y = 0;
    switch (relationType) {
        case NUIRelationTypeTop:      y = CGRectGetMinY(convertedRect); break;
        case NUIRelationTypeBottom:   y = CGRectGetMaxY(convertedRect); break;
        case NUIRelationTypeCenterY:  y = CGRectGetMidY(convertedRect); break;
        default:break;
    }
    return y - inset - CGRectGetHeight(self.newRect);
}

#pragma mark Right relations

- (NUIFramer *(^)(CGFloat))right {

    return ^id(CGFloat inset) {
        return self.right_to(self.view.superview.right, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))right_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            if (!strongSelf.isLeftFrameInstalled) {
                CGFloat x =  [strongSelf rightRelationXForView:view withInset:inset relationType:relationType];
                frame.origin.x = x;
            } else {
                frame.size.width = [strongSelf rightRelationWidthForView:view withInset:inset relationType:relationType];
            }
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (CGFloat)rightRelationWidthForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat width = 0;
    switch (relationType) {
        case NUIRelationTypeRight:      width = fabs(CGRectGetMinX(self.newRect) - CGRectGetMaxX(convertedRect)); break;
        case NUIRelationTypeLeft:       width = fabs(CGRectGetMinX(self.newRect) - CGRectGetMinX(convertedRect)); break;
        case NUIRelationTypeCenterX:    width = fabs(CGRectGetMinX(self.newRect) - CGRectGetMidX(convertedRect)); break;
        default:break;
    }
    return width - inset;
}

- (CGFloat)rightRelationXForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat x = 0;
    switch (relationType) {
        case NUIRelationTypeRight:      x = CGRectGetMaxX(convertedRect); break;
        case NUIRelationTypeLeft:       x = CGRectGetMinX(convertedRect); break;
        case NUIRelationTypeCenterX:    x = CGRectGetMidX(convertedRect); break;
        default:break;
    }
    return x - inset - CGRectGetWidth(self.newRect);
}

#pragma mark - Low priority

#pragma mark Center X relations

- (NUIFramer *(^)(CGFloat inset))super_centerX {
    
    return ^id(CGFloat inset) {
        return self.centerX_to(self.view.superview.centerX, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))centerX_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            frame.origin.x = [strongSelf centerRelationXForView:view withInset:inset relationType:relationType];
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (CGFloat)centerRelationXForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat x = 0;
    switch (relationType) {
        case NUIRelationTypeRight:      x = CGRectGetMaxX(convertedRect); break;
        case NUIRelationTypeLeft:       x = CGRectGetMinX(convertedRect); break;
        case NUIRelationTypeCenterX:    x = CGRectGetMidX(convertedRect); break;
        default:break;
    }
    return x - CGRectGetWidth(self.newRect) / 2 + inset;
}

#pragma mark Center Y relations

- (NUIFramer *(^)(CGFloat inset))super_centerY {
    
    return ^id(CGFloat inset) {
        return self.centerY_to(self.view.superview.centerY, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))centerY_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            frame.origin.y = [strongSelf centerRelationYForView:view withInset:inset relationType:relationType];
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (CGFloat)centerRelationYForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    CGFloat y = 0;
    switch (relationType) {
        case NUIRelationTypeTop:      y = CGRectGetMinY(convertedRect); break;
        case NUIRelationTypeBottom:   y = CGRectGetMaxY(convertedRect); break;
        case NUIRelationTypeCenterY:  y = CGRectGetMidY(convertedRect); break;
        default:break;
    }
    return y - CGRectGetHeight(self.newRect) / 2 + inset;
}

@end
