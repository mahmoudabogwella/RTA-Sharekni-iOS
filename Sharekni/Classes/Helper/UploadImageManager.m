//
//  SoapManager.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 12/4/15.
//
//

#import "UploadImageManager.h"
#import "Constants.h"
#import "Base64.h"
@interface UploadImageManager()<NSXMLParserDelegate>
{
    NSString *currentElement;
    NSString *result;

}
@property (nonatomic,strong) NSMutableData *webResponseData;;
@end
@implementation UploadImageManager

- (instancetype) initWithImage:(UIImage *)image Success:(void (^)(NSString *fileName))success
                       Failure:(void (^)(NSString *error))failure{
    if (self = [super init]) {
        self.image = image;
        self.successHandler = success;
        self.failureHandler = failure;
    }
    return self;
}

- (void) uploadPhoto{
    if(!self.image){
        self.failureHandler(@"");
    }
//    else{
//        NSString *imageString = [self stringFromImage:self.image];
//        self.webResponseData = [[NSMutableData alloc ] init];
//        
////        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadImage xmlns=\"http://Sharekni-MobAndroid-Data.org/UploadImage\"><ImageContent>%@</ImageContent><imageExtenstion>png</imageExtenstion></UploadImage></soap:Body></soap:Envelope>",imageString];
//        
//// NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadImage xmlns=\"http://Sharekni-MobIOS-Data.org/\"><ImageContent>%@</ImageContent><imageExtenstion>png</imageExtenstion></UploadImage></soap:Body></soap:Envelope>",imageString];
////        
//         NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadImage xmlns=\"http://Sharekni-MobAndroid-Data.org/\"><ImageContent>%@</ImageContent><imageExtenstion>png</imageExtenstion></UploadImage></soap:Body></soap:Envelope>",imageString];
//        
////         NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema-instance\"  xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadImage xmlns=\"http://Sharekni-MobAndroid-Data.org\"><ImageContent>%@</ImageContent><imageExtenstion>png</imageExtenstion></UploadImage></soap:Body></soap:Envelope>",imageString];
//        
//        
//        
//        NSURL *url = [NSURL URLWithString:@"http://sharekni-web.sdg.ae/_mobfiles/CLS_MobAndroid.asmx"];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
//        [request addValue:@"sharekni-web.sdg.ae" forHTTPHeaderField:@"Host"];
//        [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
//        [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
//        [request addValue:@"True" forHTTPHeaderField:@"SendChunked"];
//        [request addValue:@"True" forHTTPHeaderField:@"UseCookieContainer"];
//
//        [request addValue:messageLength forHTTPHeaderField:@"Content-Length"];
//        [request addValue:@"http://Sharekni-MobAndroid-Data.org/UploadImage" forHTTPHeaderField:@"SOAPAction"];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
//        [connection start];
//    }
    else{
        NSString *imageString = [self stringFromImage:self.image];
        self.webResponseData = [[NSMutableData alloc ] init];
        
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadImage xmlns=\"http://Sharekni-MobIOS-Data.org/\"><ImageContent>%@</ImageContent><imageExtenstion>png</imageExtenstion></UploadImage></soap:Body></soap:Envelope>",imageString];
        
        NSURL *url = [NSURL URLWithString:@"https://www.sharekni.ae/_mobfiles/cls_mobios.asmx"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
        [request addValue:@"www.sharekni.ae" forHTTPHeaderField:@"Host"];
        [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        [request addValue:@"True" forHTTPHeaderField:@"SendChunked"];
        [request addValue:@"True" forHTTPHeaderField:@"UseCookieContainer"];
        
        [request addValue:messageLength forHTTPHeaderField:@"Content-Length"];
        [request addValue:@"http://Sharekni-MobIOS-Data.org/UploadImage" forHTTPHeaderField:@"SOAPAction"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        [connection start];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.webResponseData  setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.webResponseData  appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
    self.failureHandler(error.localizedDescription);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Received %lu Bytes", (unsigned long)[self.webResponseData length]);
    NSString *theXML = [[NSString alloc] initWithBytes:
                        [self.webResponseData mutableBytes] length:[self.webResponseData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",theXML);
    
    //now parsing the xml
    
    NSData *myData = [theXML dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:myData];
    
    //setting delegate of XML parser to self
    xmlParser.delegate = self;
    
    // Run the parser
    @try{
        BOOL parsingResult = [xmlParser parse];
        NSLog(@"parsing result = %@",parsingResult? @"yes":@"No");
    }
    @catch (NSException* exception)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Server Error" message:[exception reason] delegate:self cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles: nil];
        [alert show];
        self.failureHandler(@"cannot parse xml");
        return;
    }
}

- (NSString *) stringFromImage:(UIImage *)image{
    NSData* data = UIImageJPEGRepresentation(image, 0.0f);
    NSString *strEncoded = [Base64 encode:data];
    return strEncoded;
}

//- (NSString*)encodeStringTo64:(NSString*)fromString
//{
//    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64String;
//    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
//        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
//    } else {
//        base64String = [plainData base64Encoding];                              // pre iOS7
//    }
//    return base64String;
//}

//Implement the NSXmlParserDelegate methods
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"UploadImageResult"]) {
        result = string;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if(result.length > 0){
        self.successHandler(result);
        NSLog(@"Parsed Element : %@", currentElement);
    }
}



@end
