//
//  Language.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "Language.h"

@implementation Language
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"LanguageId"] = @"LanguageId";
    mapping[@"LanguageArName"] = @"LanguageArName";
    mapping[@"LanguageEnName"] = @"LanguageEnName";
    mapping[@"LanguageFrName"] = @"LanguageFrName";
    mapping[@"LanguageChName"] = @"LanguageChName";
    mapping[@"LanguageUrName"] = @"LanguageUrName";
    return mapping;
}
@end
