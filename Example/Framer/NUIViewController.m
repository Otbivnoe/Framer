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
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"HELLO AGAIN! HELLO AGAIN! HELLO AGAIN! HELLO AGAIN!";
    self.label3.numberOfLines = 0;
    [self.view addSubview:self.label3];
    
    
    self.view1 = [[UIView alloc] init];
    self.view1.state = @2;
    self.view1.backgroundColor = [UIColor redColor];
    
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor blueColor];
    
    self.view3 = [[UIView alloc] init];
    self.view3.backgroundColor = [UIColor yellowColor];
    
    self.view4 = [[UIView alloc] init];
    self.view4.backgroundColor = [UIColor blackColor];
    
    self.container = [[UIView alloc] init];
    self.container.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.view1];
//    [self.view addSubview:self.view4];
//    [self.view1 addSubview:self.view2];
//    [self.view addSubview:self.view3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.view1.state = @0;
        [self.view setNeedsLayout];
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        }];
    });
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//- (void)sizeToFitSize:(CGSize)size {
//    
//    CGSize fitSize = [self sizeThatFits:size];
//    self.width = MIN(size.width, fitSize.width);
//    self.height = MIN(size.height, fitSize.height);
//}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    

//    [self.view4 installFrames:^(NUIFramer * _Nonnull framer) {
//        framer.super_centerX(0);
//        framer.super_centerY(0);
//        framer.sizeToFit();
//    }];
    
    
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(10);
        framer.height(10);
        framer.super_centerX(0).and.super_centerY(0);
    } forState:@0];
    
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(40);
        framer.height(40);
        framer.super_centerX(0).and.super_centerY(0);
    } forState:@1];
    
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(100);
        framer.height(100);
        framer.super_centerX(0).and.super_centerY(0);
    } forState:@2];
    
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

}


@end
