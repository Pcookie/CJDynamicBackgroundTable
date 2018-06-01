//
//  Show3DTouchViewController.m
//  DynamicBackgroundTable
//
//  Created by pro_cookie on 2018/06/01.
//  Copyright © 2018年 pro_cookie. All rights reserved.
//

#import "Show3DTouchViewController.h"

@interface Show3DTouchViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation Show3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.imageView.image = [UIImage imageNamed:self.imgName];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *itemA = [UIPreviewAction actionWithTitle:@"确定" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击确定");
    }];
    return @[itemA];
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
