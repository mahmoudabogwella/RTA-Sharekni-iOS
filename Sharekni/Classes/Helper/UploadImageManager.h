//
//  SoapManager.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 12/4/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UploadImageManager : NSObject
@property (nonatomic, copy) void (^successHandler)(NSString *fileName);
@property (nonatomic, copy) void (^failureHandler)(NSString *error);
@property (nonatomic,strong) UIImage * image;
- (instancetype) initWithImage:(UIImage *)image Success:(void (^)(NSString *fileName))success
                         Failure:(void (^)(NSString *error))failure;
- (void) uploadPhoto;
@end
