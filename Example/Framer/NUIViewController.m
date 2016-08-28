//
//  NUIViewController.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/14/2016.
//  Copyright (c) 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIViewController.h"

#import <Framer/Framer.h>

@interface NUIViewController ()

@property (nonatomic) UIView *view1;
@property (nonatomic) UIView *view2;
@property (nonatomic) UIView *view3;
@property (nonatomic) UIView *view4;

@property (nonatomic) UIView *container;

@property (nonatomic) UILabel *label1;
@property (nonatomic) UILabel *label2;
@property (nonatomic) UILabel *label3;

@end

@implementation NUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view1 = [[UIView alloc] init];
    self.view1.backgroundColor = [UIColor redColor];
    
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor blueColor];

    [self.view addSubview:self.view1];
    [self.view1 addSubview:self.view2];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];

    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(50);
        framer.height(150);
        framer.super_centerX(0).and.super_centerY(0);
    }];
    
    [self.view2 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.super_centerX(0);
        framer.super_centerY(0);
        framer.height_to(self.view2.nui_width, 0.5);
        framer.width_to(self.view1.nui_height, 0.5);
    }];
    
}


@end
