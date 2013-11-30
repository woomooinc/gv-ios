//
//  GVServerAPI.m
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVServerAPI.h"
#import "AFNetworking.h"
@implementation GVServerAPI
- (id) init{
    self = [super init];
    if(self){
    
    }
    return self;
}


- (void) fbServerLoginWithfb_id:(NSString *) fb_id withfb_token:(NSString *) fb_token{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"fb_id": fb_id,
                             @"fb_token": fb_token};
    [manager POST:@"http://greedyvalley.com/api/login/facebook" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self putGameWithToken:[responseObject objectForKey:@"token"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) putGameWithToken:(NSString *) token{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"token": token};
    [manager PUT:@"http://greedyvalley.com/api/games" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
