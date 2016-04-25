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
    //GreenPoint
    mapping[@"CO2Saved"] = @"CO2Saved";
    mapping[@"GreenPoints"] = @"GreenPoints";
//    mapping[@"Rating"] = @"Rating";
    
    mapping[@"LastSeen"] = @"LastSeen";

    return mapping;
}

- (void)setAccountPhoto:(NSString *)AccountPhoto
{
    __block BestDriver *blockSelf = self;
    _AccountPhoto = AccountPhoto ;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:_AccountPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        if(image){
            blockSelf.image = image;
            blockSelf.imagePath = filePath;
        }
        else{
            blockSelf.image = [UIImage imageNamed:@"thumbnail"];
            blockSelf.imagePath = nil;
        }
    } Failure:^(NSString *error) {
        blockSelf.image = [UIImage imageNamed:@"thumbnail"];
        blockSelf.imagePath = nil;
    }];
}

- (void)setAccountId:(NSString *)AccountId{
    _AccountId = AccountId;
    __block BestDriver*blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:AccountId WithSuccess:^(NSString *rating) {
        blockSelf.Rating = rating;
    } Failure:^(NSString *error) {
        blockSelf.Rating = @"0.0";
    }];
}

@end