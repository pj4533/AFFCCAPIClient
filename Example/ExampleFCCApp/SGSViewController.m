//
//  SGSViewController.m
//  ExampleFCCApp
//
//  Created by PJ Gray on 5/30/13.
//  Copyright (c) 2013 Say Goodnight Software. All rights reserved.
//

#import "SGSViewController.h"
#import "AFFCCAPIClient.h"


@interface SGSViewController ()

@end

@implementation SGSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AFFCCAPIClient sharedClient] getFIPSWithLat:@"42.343653" withLng:@"-71.097701" success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
        NSLog(@"FIPS Dictionary: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
