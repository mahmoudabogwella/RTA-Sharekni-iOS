//
//  Review.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "Review.h"
#import "MobAccountManager.h"
@implementation Review

+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"ReviewId"] = @"ReviewId";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"Review"] = @"Review";
    mapping[@"AccountName"] = @"AccountName";
    mapping[@"AccountPhoto"] = @"AccountPhoto";
    mapping[@"AccountNationalityAr"] = @"AccountNationalityAr";
    mapping[@"AccountNationalityEn"] = @"AccountNationalityEn";
    mapping[@"AccountNationalityFr"] = @"AccountNationalityFr";
    mapping[@"AccountNationalityUr"] = @"AccountNationalityUr";
    mapping[@"AccountNationalityCh"] = @"AccountNationalityCh";
    return mapping;
}

-  (void)setAccountPhoto:(NSString *)AccountPhoto{
    _AccountPhoto = AccountPhoto;
    __block Review *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:AccountPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        blockSelf.AccountImage = image;
        blockSelf.AccountImageLocalPath = filePath;
    } Failure:^(NSString *error) {
        blockSelf.AccountImage = [UIImage imageNamed:@"thumbnail"];
        blockSelf.AccountImageLocalPath = nil;
    }];
}

@end