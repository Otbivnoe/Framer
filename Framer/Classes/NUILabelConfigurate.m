//
//  NUILabelConfigurate.m
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUILabelConfigurate.h"
#import "NUIFramer.h"

@implementation NUILabelConfigurate

@synthesize class;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.class = [UILabel class];
    }
    return self;
}

- (void)additionalConfigurateForFramer:(nonnull NUIFramer *)framer {
    
    [framer.view sizeToFit];
    framer.width(CGRectGetWidth(framer.view.frame));
    framer.height(CGRectGetHeight(framer.view.frame));
}

@end
