//
//  SViewController.m
//  SRequest
//
//  Created by angelcs1990@sohu.com on 08/29/2018.
//  Copyright (c) 2018 angelcs1990@sohu.com. All rights reserved.
//

#import "SViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SDemoTestRequest.h"

@interface SViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfValue;

@end

@implementation SViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDidClicked:(id)sender {
    [[SDemoTestRequest Get]
     setNeedToken]
    .chain
    .requestUrlChain(@"/open/api/weather/json.shtml")
    .responseSerializationTypeChain(SHttpResponseSerializationJson)
    .startRequest()
    .successChain(^(id data) {
        NSLog(@"Ok");
        self.tfValue.text = @"获取数据成功";
    })
    .failureChain(^(NSError *error) {
        NSLog(@"Error");
    });
    
}

@end
