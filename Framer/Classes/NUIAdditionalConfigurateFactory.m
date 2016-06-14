//
//  NUIAdditionalConfigurateFactory.m
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIAdditionalConfigurateFactory.h"
#import "NUILabelConfigurate.h"

@implementation NUIAdditionalConfigurateFactory

+ (NSArray <id<NUIConfigurateProtocol>> *)additionalConfigurates {
    return @[[[NUILabelConfigurate alloc] init]];
}

@end
