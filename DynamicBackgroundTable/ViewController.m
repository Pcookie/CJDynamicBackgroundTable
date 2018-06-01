//
//  ViewController.m
//  DynamicBackgroundTable
//
//  Created by pro_cookie on 2018/05/31.
//  Copyright © 2018年 pro_cookie. All rights reserved.
//

#import "ViewController.h"
#import "DynamicBackgroundTableViewCell.h"
#import "Show3DTouchViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIScrollViewDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
    [self createDataSource];
    
}
#pragma mark -- 初始化tableView
- (void)createTableView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    
    [self.myTableView registerClass:[DynamicBackgroundTableViewCell class] forCellReuseIdentifier:@"DynamicBackgroundTableViewCell"];
}
- (void)createDataSource {
    for (int i = 0; i < 11; i++) {
        [self.dataSource addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
    }
}

#pragma mark -- tableView协议方法:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250 * ([UIScreen mainScreen].bounds.size.height / 667);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicBackgroundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicBackgroundTableViewCell"];
    cell.mainImageView.image = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        cell.previewingDelegate = self;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(DynamicBackgroundTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell cellOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray<DynamicBackgroundTableViewCell *> *array = [self.myTableView visibleCells];
    [array enumerateObjectsUsingBlock:^(DynamicBackgroundTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cellOffset];
    }];
    
}
#pragma mark -- 3DTouch
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    if (viewControllerToCommit){
        [self showViewController:viewControllerToCommit sender:self];
    }
}
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    Show3DTouchViewController *detailVC = [Show3DTouchViewController new];
    detailVC.imgName = [NSString stringWithFormat:@"%d", indexPath.row];
    CGRect rect = CGRectMake(0, 0,  previewingContext.sourceView.frame.size.width, previewingContext.sourceView.frame.size.height);
    previewingContext.sourceRect = rect;
    return detailVC;
}




@end
