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

//    self.label1 = [[UILabel alloc] init];
//    self.label1.text = @"HELLO1!";
//    [self.view addSubview:self.label1];
//    
//    self.label2 = [[UILabel alloc] init];
//    self.label2.text = @"ALL GOOOD";
//    [self.view addSubview:self.label2];
//    
//    self.label3 = [[UILabel alloc] init];
//    self.label3.text = @"HELLO AGAIN!";
//    [self.view addSubview:self.label3];
    
    
    self.view1 = [[UIView alloc] init];
    self.view1.backgroundColor = [UIColor redColor];
    
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor blueColor];
    
    self.view3 = [[UIView alloc] init];
    self.view3.backgroundColor = [UIColor yellowColor];
    
    self.container = [[UIView alloc] init];
    self.container.backgroundColor = [UIColor blackColor];
    
//    [self.view addSubview:self.view1];
//    [self.view addSubview:self.view2];
//    [self.view addSubview:self.view3];

    
    [self.container addSubview:self.view1];
    [self.container addSubview:self.view2];
    [self.container addSubview:self.view3];
    [self.view addSubview:self.container];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
//    [self.view1 installFrames:^(NUIFramer *framer) {
//        framer.width(40);
//        framer.height(40);
//        framer.top(0).and.left(10);
//    }];
//    
//    [self.view2 installFrames:^(NUIFramer *framer) {
//        framer.width(20);
//        framer.height(20);
//        framer.top_to(self.view1.bottom, 10);
//        framer.left(10);
//    }];
//    
//    [self.view3 installFrames:^(NUIFramer *framer) {
//        framer.width(20);
//        framer.height(20);
//        framer.top_to(self.view2.bottom, 10);
//        framer.left(10);
//    }];
    
    [self.view1 installFrames:^(NUIFramer *framer) {
        framer.width(40);
        framer.height(40);
        framer.top(50).and.left(50);
    }];
    
    [self.view2 installFrames:^(NUIFramer *framer) {
        framer.width(20);
        framer.height(20);
        framer.bottom_to(self.view1.top, 10);
        framer.left(0);
    }];
    
    [self.view3 installFrames:^(NUIFramer *framer) {
        framer.width(20);
        framer.height(20);
        framer.top(10);
        framer.left_to(self.view2.right, 40);
    }];
    
    [self.container installFrames:^(NUIFramer *framer) {
        framer.super_centerX(0);
        framer.super_centerY(0);
        framer.container();
    }];
}


@end
