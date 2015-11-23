//
//  BestDriver.m
//  Sharekni
//
//  Created by Ahmed Askar on 10/9/15.
//
//

#import "BestDriver.h"
#import "MobAccountManager.h"

@implementation BestDriver

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"AccountName"] = @"AccountName";
    mapping[@"AccountPhoto"] = @"AccountPhoto";
    mapping[@"AccountMobile"] = @"AccountMobile";
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationalityEnName"] = @"NationalityEnName";
    mapping[@"NationalityFrName"] = @"NationalityFrName";
    mapping[@"NationalityChName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";
    mapping[@"Rating"] = @"Rating";
    return mapping;
}

- (void)setAccountPhoto:(NSString *)AccountPhoto
{
    _AccountPhoto = AccountPhoto ;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:_AccountPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        self.image = image ;
        self.imagePath = filePath;
    } Failure:^(NSString *error) {
        
    }];
}

@end