//
//  Emirate.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "Emirate.h"

@implementation Emirate
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"EmirateId"] = @"EmirateId";
    mapping[@"EmirateArName"] = @"EmirateArName";
    mapping[@"EmirateEnName"] = @"EmirateEnName";
    mapping[@"EmirateFrName"] = @"EmirateFrName";
    mapping[@"EmirateChName"] = @"EmirateChName";
    mapping[@"EmirateUrName"] = @"EmirateUrName";
    return mapping;
}
@end
