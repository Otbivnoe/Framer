//
//  UIView+NUIAdditions.m
//  Pods
//
//  Created by Nikita on 19/06/16.
//
//

#import "UIView+NUIAdditions.h"
#import <objc/runtime.h>

@implementation UIView (NUIAdditions)

- (UIView *)left {
    
    self.relationType = NUIRelationTypeLeft;
    return self;
}

- (UIView *)right {
    
    self.relationType = NUIRelationTypeRight;
    return self;
}

- (UIView *)top {
    
    self.relationType = NUIRelationTypeTop;
    return self;
}

- (UIView *)bottom {
    
    self.relationType = NUIRelationTypeBottom;
    return self;
}

- (UIView *)centerX {
    
    self.relationType = NUIRelationTypeCenterX;
    return self;
}

- (UIView *)centerY {
    
    self.relationType = NUIRelationTypeCenterY;
    return self;
}

#pragma mark - Runtime

- (void)setRelationType:(NUIRelationType)relationType {
    
    objc_setAssociatedObject(self, @selector(relationType), @(relationType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NUIRelationType)relationType {
    
    return [objc_getAssociatedObject(self, @selector(relationType)) integerValue];
}

@end
