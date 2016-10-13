//
//  NUIFramer.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIFramer.h"
#import "NUIHandler.h"
#import "NUIHandlerInfo.h"

#import "UIView+NUIAdditions.h"
#import "UIView+NUIInstaller.h"

@interface NUIFramer ()

@property (nonatomic, getter=isTopFrameInstalled) BOOL topFrameInstalled;
@property (nonatomic, getter=isLeftFrameInstalled) BOOL leftFrameInstalled;

@property (nonatomic, nonnull) NSMutableArray <NUIHandlerInfo *> *handlerInfos;
@property (nonatomic, nonnull) NSMutableArray <NUIHandler *> *handlers;
@property (nonatomic) CGRect newRect;

@property (nonatomic, weak, nullable) UIView *view;

@end

@implementation NUIFramer

#pragma mark - Initialize

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _handlerInfos = [[NSMutableArray alloc] init];
        _handlers = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Configurate methods

+ (void)configurateView:(UIView *)view withInstallerBlock:(InstallerBlock)installerBlock {
    
    [self configurateView:view forState:@0 withInstallerBlock:installerBlock];
}

+ (void)configurateView:(UIView *)view forState:(NSNumber *)state withInstallerBlock:(InstallerBlock)installerBlock {

    if (view.nui_state.integerValue == state.integerValue) {
        NUIFramer *framer = [[NUIFramer alloc] init];
        framer.view = view;
        
        [framer startConfigurate];
        
        if (installerBlock) {
            installerBlock(framer);
        }
        [framer configurateFrames];
    }
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
    
    [self configurateOrderHandlers];
    
    [self.handlers enumerateObjectsUsingBlock:^(NUIHandler * _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
        handler.handlerBlock();
    }];
    [self endConfigurate];
}

#pragma mark - Helpers

- (NUIHandlerInfo *)infoForType:(NUIRelationType)type {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"handlerType == %@", @(type)];
    return [self.handlerInfos filteredArrayUsingPredicate:predicate].firstObject;
}

- (CGFloat)valueForRelationType:(NUIRelationType)type forView:(UIView *)view {
    
    CGRect convertedRect = [self.view.superview convertRect:view.frame fromView:view.superview];
    switch (type) {
        case NUIRelationTypeTop:      return CGRectGetMinY(convertedRect);
        case NUIRelationTypeBottom:   return CGRectGetMaxY(convertedRect);
        case NUIRelationTypeCenterY:  return CGRectGetMidY(convertedRect);
        case NUIRelationTypeCenterX:  return CGRectGetMidX(convertedRect);
        case NUIRelationTypeRight:    return CGRectGetMaxX(convertedRect);
        case NUIRelationTypeLeft:     return CGRectGetMinX(convertedRect);
        default: return 0;
    }
}

#pragma mark - Framer methods

- (NUIFramer *)and {
    return self;
}

#pragma mark - Top priority

#pragma mark Width / Height relations

- (NUIFramer* (^)(CGFloat))width {
    
    return ^id(CGFloat width) {
        [self setHighPriorityValue:width withType:NUIRelationTypeWidth];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))width_to {
    
    return ^id(UIView * view, CGFloat multiplier) {

        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (view != strongSelf.view) {
                CGFloat width = [strongSelf sizeForView:view withRelationType:relationType] * multiplier;
                [strongSelf setFrameValue:width type:NUIRelationTypeWidth];
            } else {
                NUIHandlerInfo *heightInfo = [strongSelf infoForType:NUIRelationTypeHeight];
                if (heightInfo) {
                    CGFloat width = [heightInfo.first floatValue];
                    [strongSelf setFrameValue:width*multiplier type:NUIRelationTypeWidth];
                    
                } else if ([strongSelf infoForType:NUIRelationTypeHeightTo]) {
                    NUIHandlerInfo *heightToInfo = [strongSelf infoForType:NUIRelationTypeHeightTo];
                    
                    UIView *tempRelationView = heightToInfo.first;
                    CGFloat tempMultiplier = [heightToInfo.third floatValue];
                    NUIRelationType relationType = [heightToInfo.second integerValue];
                    
                    CGFloat width = [strongSelf sizeForView:tempRelationView withRelationType:relationType] * (tempMultiplier*multiplier);
                    [strongSelf setFrameValue:width type:NUIRelationTypeWidth];
                    
                } else {
                    NUIHandlerInfo *topInfo = [strongSelf infoForType:NUIRelationTypeTop];
                    NUIHandlerInfo *bottomInfo = [strongSelf infoForType:NUIRelationTypeBottom];
                    
                    if (topInfo && bottomInfo) {
                        UIView *topView = topInfo.first;
                        CGFloat topInset = [topInfo.second floatValue];
                        NUIRelationType topRelationType = [topInfo.third integerValue];
                        
                        CGFloat topViewY = [strongSelf topRelationYForView:topView withInset:topInset relationType:topRelationType];
                        
                        UIView *bottomView = bottomInfo.first;
                        CGFloat bottomInset = [bottomInfo.second floatValue];
                        NUIRelationType bottomRelationType = [bottomInfo.third integerValue];
                        
                        CGFloat bottomViewY = [strongSelf valueForRelationType:bottomRelationType forView:bottomView] - bottomInset;
                        
                        [strongSelf setFrameValue:(bottomViewY - topViewY)*multiplier type:NUIRelationTypeWidth];
                    }
                }
            }
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeWidthTo parameters:view, @(relationType), @(multiplier), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (NUIFramer* (^)(CGFloat))height {
    
    return ^id(CGFloat height) {
        [self setHighPriorityValue:height withType:NUIRelationTypeHeight];
        return self;
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))height_to {
    
    return ^id(UIView * view, CGFloat multiplier) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (view != strongSelf.view) {
                CGFloat height = [strongSelf sizeForView:view withRelationType:relationType] * multiplier;
                [strongSelf setFrameValue:height type:NUIRelationTypeHeight];
            } else {
                NUIHandlerInfo *widthInfo = [strongSelf infoForType:NUIRelationTypeWidth];
                if (widthInfo) {
                    CGFloat height = [widthInfo.first floatValue];
                    [strongSelf setFrameValue:height*multiplier type:NUIRelationTypeHeight];
                    
                } else if ([strongSelf infoForType:NUIRelationTypeWidthTo]) {
                    NUIHandlerInfo *widthToInfo = [strongSelf infoForType:NUIRelationTypeWidthTo];
                    
                    UIView *tempRelationView = widthToInfo.first;
                    CGFloat tempMultiplier = [widthToInfo.third floatValue];
                    NUIRelationType relationType = [widthToInfo.second integerValue];
                    
                    CGFloat height = [strongSelf sizeForView:tempRelationView withRelationType:relationType] * (tempMultiplier*multiplier);
                    [strongSelf setFrameValue:height type:NUIRelationTypeHeight];
                    
                } else {
                    NUIHandlerInfo *leftInfo = [strongSelf infoForType:NUIRelationTypeLeft];
                    NUIHandlerInfo *rightInfo = [strongSelf infoForType:NUIRelationTypeRight];
                    
                    if (leftInfo && rightInfo) {
                        UIView *leftView = leftInfo.first;
                        CGFloat leftInset = [leftInfo.second floatValue];
                        NUIRelationType leftRelationType = [leftInfo.third integerValue];
                        
                        CGFloat leftViewX = [strongSelf leftRelationXForView:leftView withInset:leftInset relationType:leftRelationType];
                        
                        UIView *rightView = rightInfo.first;
                        CGFloat rightInset = [rightInfo.second floatValue];
                        NUIRelationType rightRelationType = [rightInfo.third integerValue];
                        
                        CGFloat rightViewX = [strongSelf valueForRelationType:rightRelationType forView:rightView] - rightInset;
                        
                        [strongSelf setFrameValue:(rightViewX - leftViewX)*multiplier type:NUIRelationTypeHeight];
                    }
                }
            }
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeHeightTo parameters:view, @(relationType), @(multiplier), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (CGFloat)sizeForView:(UIView *)view withRelationType:(NUIRelationType)relationType {
    
    if (relationType == NUIRelationTypeWidth) {
        return CGRectGetWidth(view.bounds);
    } else if (relationType == NUIRelationTypeHeight) {
        return CGRectGetHeight(view.bounds);
    }
    return 0;
}

- (void)setHighPriorityValue:(CGFloat)value withType:(NUIRelationType)type {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_block_t handler = ^ {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setFrameValue:value type:type];
    };
    
    [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:type parameters:@(value), nil]];
    [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
}

- (void)setFrameValue:(CGFloat)value type:(NUIRelationType)type {
    
    CGRect frame = self.newRect;
    switch (type) {
        case NUIRelationTypeWidth:
            frame.size.width = value;
            break;
        case NUIRelationTypeHeight:
            frame.size.height = value;
            break;
        default:break;
    }
    self.newRect = frame;
}

#pragma mark Left relations

- (NUIFramer *(^)(CGFloat))left {

    return ^id(CGFloat inset) {
        return self.left_to(self.view.superview.nui_left, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))left_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat x = [strongSelf leftRelationXForView:view withInset:inset relationType:relationType];
            CGRect frame = strongSelf.newRect;
            frame.origin.x = x;
            strongSelf.newRect = frame;
            strongSelf.leftFrameInstalled = YES;
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeLeft parameters:view, @(inset), @(relationType), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (CGFloat)leftRelationXForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {

    CGFloat x = [self valueForRelationType:relationType forView:view];
    return x + inset;
}

#pragma mark Top relations

- (NUIFramer *(^)(CGFloat))top {
    
    return ^id(CGFloat inset) {
        return self.top_to(self.view.superview.nui_top, inset);
    };
}

- (NUIFramer *(^)(UIView *, CGFloat))top_to {
    
    return ^id(UIView *view, CGFloat inset) {
        
        __weak typeof(self) weakSelf = self;
        NUIRelationType relationType = view.relationType;
        
        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGFloat y = [strongSelf topRelationYForView:view withInset:inset relationType:relationType];
            CGRect frame = strongSelf.newRect;
            frame.origin.y = y;
            strongSelf.newRect = frame;
            strongSelf.topFrameInstalled = YES;
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeTop parameters:view, @(inset), @(relationType), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityHigh]];
        return self;
    };
}

- (CGFloat)topRelationYForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGFloat y = [self valueForRelationType:relationType forView:view];
    return y + inset;
}

#pragma mark Container

- (NUIFramer *(^)())container {
    
    return ^id() {
        CGRect frame = CGRectZero;
        for (UIView *subview in [self.view subviews]) {
            frame = CGRectUnion(frame, subview.frame);
        }

        [self setHighPriorityValue:CGRectGetWidth(frame) withType:NUIRelationTypeWidth];
        [self setHighPriorityValue:CGRectGetHeight(frame) withType:NUIRelationTypeHeight];
        return self;
    };
}

#pragma mark Fits

- (NUIFramer *(^)())sizeToFit {
    
    return ^id() {
        [self.view sizeToFit];
        [self setHighPriorityValue:CGRectGetWidth(self.view.frame) withType:NUIRelationTypeWidth];
        [self setHighPriorityValue:CGRectGetHeight(self.view.frame) withType:NUIRelationTypeHeight];
        return self;
    };
}

- (NUIFramer *(^)())widthToFit {
    
    return ^id() {
        [self.view sizeToFit];
        [self setHighPriorityValue:CGRectGetWidth(self.view.frame) withType:NUIRelationTypeWidth];
        return self;
    };
}

- (NUIFramer *(^)())heightToFit {
    
    return ^id() {
        [self.view sizeToFit];
        [self setHighPriorityValue:CGRectGetHeight(self.view.frame) withType:NUIRelationTypeHeight];
        return self;
    };
}

- (NUIFramer *(^)(CGSize size))sizeThatFits {
    
    return ^id(CGSize size) {
        CGSize fitSize = [self.view sizeThatFits:size];
        CGFloat width = MIN(size.width, fitSize.width);
        CGFloat height = MIN(size.height, fitSize.height);
        [self setHighPriorityValue:width withType:NUIRelationTypeWidth];
        [self setHighPriorityValue:height withType:NUIRelationTypeHeight];
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
        return self.bottom_to(self.view.superview.nui_bottom, inset);
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
                CGFloat y = [strongSelf bottomRelationYForView:view withInset:inset relationType:relationType];
                frame.origin.y = y;
            } else {
                frame.size.height = [strongSelf bottomRelationHeightForView:view withInset:inset relationType:relationType];;
            }
            strongSelf.newRect = frame;
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeBottom parameters:view, @(inset), @(relationType), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (CGFloat)bottomRelationHeightForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {

    CGFloat height = fabs(CGRectGetMinY(self.newRect) - [self valueForRelationType:relationType forView:view]);
    return height - inset;
}

- (CGFloat)bottomRelationYForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGFloat y = [self valueForRelationType:relationType forView:view];
    return y - inset - CGRectGetHeight(self.newRect);
}

#pragma mark Right relations

- (NUIFramer *(^)(CGFloat))right {

    return ^id(CGFloat inset) {
        return self.right_to(self.view.superview.nui_right, inset);
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
                frame.size.width = [strongSelf rightRelationWidthForView:view withInset:inset relationType:relationType];;
            }
            strongSelf.newRect = frame;
        };
        
        [self.handlerInfos addObject:[NUIHandlerInfo infoWithType:NUIRelationTypeRight parameters:view, @(inset), @(relationType), nil]];
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityMiddle]];
        return self;
    };
}

- (CGFloat)rightRelationWidthForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {

    CGFloat width = fabs(CGRectGetMinX(self.newRect) - [self valueForRelationType:relationType forView:view]);
    return width - inset;
}

- (CGFloat)rightRelationXForView:(UIView *)view withInset:(CGFloat)inset relationType:(NUIRelationType)relationType {
    
    CGFloat x = [self valueForRelationType:relationType forView:view];
    return x - inset - CGRectGetWidth(self.newRect);
}

#pragma mark - Low priority

#pragma mark Center X relations

- (NUIFramer *(^)(CGFloat))centerX {
    
    return ^id(CGFloat x) {
        
        __weak typeof(self) weakSelf = self;

        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            frame.origin.x = x - CGRectGetWidth(frame)/2;
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(CGFloat))centerY {
    
    return ^id(CGFloat y) {
        
        __weak typeof(self) weakSelf = self;

        dispatch_block_t handler = ^ {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGRect frame = strongSelf.newRect;
            frame.origin.y = y - CGRectGetHeight(frame)/2;
            strongSelf.newRect = frame;
        };
        [self.handlers addObject:[NUIHandler handlerWithBlock:handler priority:NUIHandlerPriorityLow]];
        return self;
    };
}

- (NUIFramer *(^)(CGFloat inset))super_centerX {
    
    return ^id(CGFloat inset) {
        return self.centerX_to(self.view.superview.nui_centerX, inset);
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

    CGFloat x = [self valueForRelationType:relationType forView:view];
    return x - CGRectGetWidth(self.newRect) / 2 - inset;
}

#pragma mark Center Y relations

- (NUIFramer *(^)(CGFloat inset))super_centerY {
    
    return ^id(CGFloat inset) {
        return self.centerY_to(self.view.superview.nui_centerY, inset);
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
    
    CGFloat y = [self valueForRelationType:relationType forView:view];
    return y - CGRectGetHeight(self.newRect) / 2 - inset;
}

@end
