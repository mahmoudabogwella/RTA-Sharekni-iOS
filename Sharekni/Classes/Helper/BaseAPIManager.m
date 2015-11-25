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
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [requestSerializer setValue:@"application/x-www-form-urlencoded " forHTTPHeaderField:@"Content-Type"];

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
    string = [string stringByReplacingOccurrencesOfString:XML_Tag2 withString:@""];
    string = [string stringByReplacingOccurrencesOfString:XML_Tag3 withString:@""];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
                NSString *base64tag5 = @"<base64Binary xmlns=\"http://Sharekni-MobIOS-Data.org/\">";
                
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag1 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag2 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag3 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64tag4 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64tag5 withString:@""];
                responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
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

- (void) uploadPhoto:(UIImage *)image withSuccess:(void (^)(NSString *fileName))success
                  Failure:(void (^)(NSString *error))failure{
    if(!image){
        failure(@"No Image ");
    }
    else{
        NSString *imageString = [self stringFromImage:image];
        NSString *path = [NSString stringWithFormat:@"cls_mobios.asmx/UploadImage?ImageContent=%@&ImageContent=%@&imageExtenstion=png",imageString,imageString];
        [self.operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"Image Uploaded YES");
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"Image Uploaded NO");
        }];
    }
}

- (NSString *) stringFromImage:(UIImage *)image{
    NSData* data = UIImageJPEGRepresentation(image, 0.0f);
    NSString *strEncoded = [Base64 encode:data];
    return strEncoded;
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
