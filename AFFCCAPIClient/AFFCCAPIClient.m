// AFFCCAPIClient.m
// 
// Copyright (c) 2013 Say Goodnight Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFFCCAPIClient.h"

@implementation AFFCCAPIClient
+ (AFFCCAPIClient*) fccAPIClient {
    NSString* urlString = @"http://data.fcc.gov/api/";
    AFFCCAPIClient* client = [[AFFCCAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    client.parameterEncoding = AFJSONParameterEncoding;
    return client;
    
}

- (void)getFIPSWithLat:(NSString*) lat
               withLng:(NSString*) lng
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary* params = @{
                             @"latitude": lat,
                             @"longitude": lng,
                             @"format": @"json",
                             };
    [super getPath:@"block/find" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* blockDict = [responseObject objectForKey:@"Block"];
            if (blockDict) {
                NSString* blockFIPS = [blockDict objectForKey:@"FIPS"];
                success(operation, [self dictFromFIPS:blockFIPS]);
            } else {
                NSLog(@"BLOCK NOT FOUND: %@", responseObject);
            }
        }
    } failure:failure];
    
}

- (NSDictionary*) dictFromFIPS:(NSString*) fips {
    
    NSDictionary* returnDict = @{
                                 @"state": [fips substringWithRange:NSMakeRange(0, 2)],
                                 @"county": [fips substringWithRange:NSMakeRange(2, 3)],
                                 @"tract": [fips substringWithRange:NSMakeRange(5, 6)],
                                 @"block": [fips substringWithRange:NSMakeRange(11, 4)],
                                 };
    
    return returnDict;
}

@end
