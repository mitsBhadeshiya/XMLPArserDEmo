//
//  MainViewController.m
//  XMLParserT
//
//  Created by MitulB on 19/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "MainViewController.h"
#import "XMLParser.h"
@interface MainViewController ()

@end

@implementation MainViewController

@synthesize arrList;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // http://api.geonames.org/neighbours?geonameId=2658434&username=mitul

    NSURL *aUrl = [NSURL URLWithString:@"http://api.geonames.org/neighbours?geonameId=2658434&username=mitul"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    //NSString *postString = @"action=userfavorite&type=usersList&userid=1";
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    if (connection) {
        receiveData = [NSMutableData data];
    }
}


#pragma mark -
#pragma mark - NSURL CONNECTION DELEGATE

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    receiveData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [receiveData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSDictionary *dict=[XMLParser dictionaryForXMLData:receiveData error:nil];
    
    NSLog(@"%@ ", dict);
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"GETTING ERROR %@", error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
