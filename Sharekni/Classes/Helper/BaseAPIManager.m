//
//  BaseAPIManager.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/27/15.
//
//

#import "BaseAPIManager.h"
#import "Constants.h"
#import "HelpManager.h"
#import "Base64.h"
@implementation BaseAPIManager
- (instancetype)init{
    if (self = [super init]) {
        
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:Sharkeni_BASEURL]];
//        self.operationManager.ser
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
        [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
        self.operationManager.requestSerializer = requestSerializer;
        
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        [responseSerializer.acceptableContentTypes setByAddingObject:@"application/xml"];
        self.operationManager.responseSerializer = responseSerializer;
    }
    return self;
}

- (NSString *) jsonStringFromResponse:(NSString *)response{
    NSString *string = [response stringByReplacingOccurrencesOfString:XML_Open_Tag withString:@""];
    string = [string stringByReplacingOccurrencesOfString:String_Open_Tag withString:@""];
    string = [string stringByReplacingOccurrencesOfString:String_Close_Tag withString:@""];
    string = [string stringByReplacingOccurrencesOfString:XML_Tag1 withString:@""];
    return  string;
}


- (void) GetPhotoWithName:(NSString *)name withSuccess:(void (^)(UIImage *image,NSString *filePath))success
                  Failure:(void (^)(NSString *error))failure{
    if([name isEqualToString:@"NoImage.png"]){
        success(nil,nil);
    }
    else{
        NSString *imagesDirectory = [[HelpManager sharedHelpManager] imagesDirectory];
        NSString *path = [imagesDirectory stringByAppendingPathComponent:name];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            success(image,path);
        }
        else{
            NSDictionary *parameters = @{fileName_KEY:name};
            [self.operationManager GET:GetPhoto_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
                NSLog(@"%@",responseObject);
                NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSString *base64Tag1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                NSString *base64Tag2 = @"<base64Binary xmlns=\"http://MobAccount.org/\">";
                NSString *base64Tag3 = @"</base64Binary>";
                NSString *base64tag4 = @"<base64Binary xmlns=\"http://tempuri.org/\">";
                
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag1 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag2 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag3 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64tag4 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
                NSLog(@"string %@",responseString);
//                NSString *test = @"asdasdasdasdasdasdqweqweqweqwejkbnjknknk";
//                NSString * x = [self encodeStringTo64:test];
//                responseString = [self encodeStringTo64:responseString];
                responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSData* data = [Base64 decode:responseString];
                UIImage *image = [UIImage imageWithData:data];
                NSData *pngData = UIImagePNGRepresentation(image);
                [pngData writeToFile:path atomically:YES];
                success(image,path);
            } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
                NSLog(@"Error %@",error.description);
                failure(error.description);
            }];
        }
    }
}

- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64Encoding];                              // pre iOS7
    }
    return base64String;
}



@end
