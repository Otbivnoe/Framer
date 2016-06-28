//
//  NUIFramerRelationLogicSpec.m
//  Framer
//
//  Created by Nikita Ermolenko on 28/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Framer/Framer.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(RELATIONSPEC)

describe(@"Framer", ^{
   
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    UIView *testingView = [[UIView alloc] init];
    
    beforeAll(^{
        [mainView addSubview:testingView];
    });
    
    beforeEach(^{
        testingView.frame = CGRectZero;
    });
    
    context(@"should correctly builds relations", ^{
        
        it(@"for 'bottom' and 'top' configurations together", ^{
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerX(0);
                framer.width(100);
                framer.bottom(10).and.top(10);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(200, 10, 100, 480))];
        });
        
        it(@"for 'bottom' and 'height' configurations together", ^{
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerX(0);
                framer.width(100).and.height(100);
                framer.bottom(10);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(200, 390, 100, 100))];
        });
        
        it(@"for 'right' and 'left' configurations together", ^{
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerY(0);
                framer.height(100);
                framer.left(10).and.right(10);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(10, 200, 480, 100))];
        });
        
        it(@"for 'right' and 'width' configurations together", ^{
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerY(0);
                framer.height(100).and.width(100);
                framer.right(10);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(390, 200, 100, 100))];
        });
        
    });
    
});

SPEC_END
