//
//  NUIFramerStateSpec.m
//  Framer
//
//  Created by Nikita on 29/07/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Framer/Framer.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(STATESPEC)

describe(@"Framer", ^{
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    UIView *testingView = [[UIView alloc] init];
    
    beforeAll(^{
        [mainView addSubview:testingView];
    });
    
    beforeEach(^{
        testingView.frame = CGRectZero;
    });
    
    it(@"should correctly configures frame for any available state", ^{
        
        testingView.state = @0;
        
        [testingView installFrames:^(NUIFramer * _Nonnull framer) {
            framer.width(10);
            framer.height(10);
            framer.super_centerX(0).and.super_centerY(0);
        }];
        
        [testingView installFrames:^(NUIFramer * _Nonnull framer) {
            framer.width(40);
            framer.height(40);
            framer.super_centerX(0).and.super_centerY(0);
        } forState:@1];
        
        [testingView installFrames:^(NUIFramer * _Nonnull framer) {
            framer.width(100);
            framer.height(100);
            framer.super_centerX(0).and.super_centerY(0);
        } forState:@2];
    
        [testingView applyFrameForState:@2];
        [[theValue(testingView.frame) should] equal:theValue(CGRectMake(200, 200, 100, 100))];
        
        [testingView applyFrameForState:@0];
        [[theValue(testingView.frame) should] equal:theValue(CGRectMake(245, 245, 10, 10))];
    });
    
});

SPEC_END