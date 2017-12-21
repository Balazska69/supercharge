//
//  NetworkManager.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (NetworkManager *)getInstance {
    static dispatch_once_t pred;
    __strong static id sharedInstance = nil;
    dispatch_once( &pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

- (void)sendRequestWithParameters:(NSDictionary *)params headers:(NSDictionary *)headers toURLTail:(NSString *)urlTail methodType:(NSString *)methodType needErrorPopup:(BOOL)needErrorPopup completion: (AsyncNetworkSuccessCallback)completion {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kmainURL, urlTail]];
    NSData *postData = [self encodeDictionary:params];
    
    if ([urlTail isEqualToString:@"/app_end_points/reportNetworkError?isAppRequest=1"]) {
        postData = [NSJSONSerialization dataWithJSONObject:[params objectForKey:@"networkErrors"] options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString *bodyJsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"==========> SEND BODY TO SERVER:\n%@",bodyJsonString);
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    if (headers != nil) {
        NSArray* keys = [headers allKeys];
        for(int i = 0; i<[keys count]; i++) {
            NSString* headerName = [keys objectAtIndex:i];
            NSString* headerContent = [headers objectForKey:headerName];
            [request setValue:headerContent forHTTPHeaderField:headerName];
        }
    }
    
    if ([methodType isEqualToString:@"POST"]) {
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    } else {
        NSMutableString *getUrlString = [NSMutableString stringWithFormat:@"%@%@", kmainURL, urlTail];
        
        int i = 0;
        for (NSString *key in params.allKeys) {
            if (i == 0) {
                [getUrlString appendString:[NSString stringWithFormat:@"?%@=%@", key, [params objectForKey:key]]];
            } else {
                [getUrlString appendString:[NSString stringWithFormat:@"&%@=%@", key, [params objectForKey:key]]];
            }
            i++;
        }
        
        url = [NSURL URLWithString:[getUrlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        request = [NSMutableURLRequest requestWithURL:url];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    }
    
    [request setHTTPMethod:methodType];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 30.0f;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Perform the request
        NSURLResponse *response;
        NSError *error = nil;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *returnDictionary = nil;
            NSString *returnResultString = nil;
            if (receivedData) {
                returnDictionary = [NSJSONSerialization JSONObjectWithData:(NSData *)receivedData options:NSJSONReadingMutableContainers error:nil];
                if ([[[[returnDictionary objectForKey:@"page"] objectForKey:@"app"] objectForKey:@"app"] isKindOfClass:[NSDictionary class]]) {
                    if ([[[[returnDictionary objectForKey:@"page"] objectForKey:@"app"] objectForKey:@"app"] objectForKey:@"return"]) {
                        returnResultString = [[[[returnDictionary objectForKey:@"page"] objectForKey:@"app"] objectForKey:@"app"] objectForKey:@"result"];
                    }
                }
            }
            
            if (error) {
                // Deal with your error
                NSLog(@"Error %@", error);
                
                if (error.code == NSURLErrorTimedOut) {
                    return completion([NSError errorWithDomain:@"network.timedout" code:NSURLErrorTimedOut userInfo:nil], nil);
                }
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
//            if ([response respondsToSelector:@selector(allHeaderFields)]) {
//                NSDictionary *headersDictionary = [httpResponse allHeaderFields];
//            }
            
            if (httpResponse.statusCode != 200) {
                NSLog(@"HTTP ERROR: %ld", (long)httpResponse.statusCode);
                return completion([NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:nil], nil);
            }
            
            NSString *responeString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
            NSLog(@"==========> GOT DATA FROM SERVER FOR URL:%@\n%@ with params:%@", request.URL.absoluteString, responeString, [params description]);
            //            NSLog(@"==========> GOT DATA FROM SERVER FOR URL:%@\n", request.URL.absoluteString);
            return completion(error, receivedData);
        });
    });
}

- (NSData *)encodeDictionary:(NSDictionary*)dictionary {
    if (dictionary) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        return jsonData;
    }
    
    return nil;
}

- (void)getXmasDailyStatusesWithCompletion:(AsyncNetworkSuccessCallback)completion {
    [self sendRequestWithParameters:@{@"isAppRequest" : @"1", @"appsid" : @"425e9de9254a5660887265993d61e755", @"timestamp" : [NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]]} headers:nil toURLTail:@"/app_end_points/getXmasDailyStatuses" methodType:@"GET" needErrorPopup:NO completion:completion];
}

@end
