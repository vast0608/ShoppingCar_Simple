//
//  ViewController.m
//  ShoppingCar
//
//  Created by 上海烨历网络科技有限公司 on 2017/6/14.
//  Copyright © 2017年 上海烨历网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingCraVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)button:(id)sender {
    ShoppingCraVC *sVC = [ShoppingCraVC new];
    [self.navigationController pushViewController:sVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
