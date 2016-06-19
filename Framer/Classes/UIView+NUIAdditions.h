//
//  UIView+NUIAdditions.h
//  Pods
//
//  Created by Nikita on 19/06/16.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NUIRelationType) {
    NUIRelationTypeLeft,
    NUIRelationTypeRight,
    NUIRelationTypeTop,
    NUIRelationTypeBottom,
    NUIRelationTypeCenterX,
    NUIRelationTypeCenterY
};

@interface UIView (NUIAdditions)

@property (nonatomic, readonly) NUIRelationType relationType;

@property (nonatomic, readonly) UIView *left;
@property (nonatomic, readonly) UIView *right;
@property (nonatomic, readonly) UIView *top;
@property (nonatomic, readonly) UIView *bottom;
@property (nonatomic, readonly) UIView *centerX;
@property (nonatomic, readonly) UIView *centerY;

@end
