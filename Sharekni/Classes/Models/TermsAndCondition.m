//
//  TermsAndCondition.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "TermsAndCondition.h"

@implementation TermsAndCondition
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"TextAr"] = @"TextAr";
    mapping[@"TextEn"] = @"TextEn";
    mapping[@"TextFr"] = @"TextFr";
    mapping[@"TextCh"] = @"TextCh";
    mapping[@"TextUr"] = @"TextUr";
    return mapping;
}
@end
