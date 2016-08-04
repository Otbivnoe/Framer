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

- (UIView *)nui_width {
    
    self.relationType = NUIRelationTypeWidth;
    return self;
}

- (UIView *)nui_height {
    
    self.relationType = NUIRelationTypeHeight;
    return self;
}

- (UIView *)nui_left {
    
    self.relationType = NUIRelationTypeLeft;
    return self;
}

- (UIView *)nui_right {
    
    self.relationType = NUIRelationTypeRight;
    return self;
}

- (UIView *)nui_top {
    
    self.relationType = NUIRelationTypeTop;
    return self;
}

- (UIView *)nui_bottom {
    
    self.relationType = NUIRelationTypeBottom;
    return self;
}

- (UIView *)nui_centerX {
    
    self.relationType = NUIRelationTypeCenterX;
    return self;
}

- (UIView *)nui_centerY {
    
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
