//
//  BaseAPIManager.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/27/15.
//
//

#import "BaseAPIManager.h"
#import "Constants.h"
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
@end
