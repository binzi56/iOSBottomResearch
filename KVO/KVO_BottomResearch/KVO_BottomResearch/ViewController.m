//
//  ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView * _mainTableView;
    NSArray     * _dataArr;
}

@end

@implementation ViewController


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *tempDic = _dataArr[indexPath.section];
    NSArray *valueArr = tempDic[@"value"];
    NSArray *classArr = tempDic[@"class"];
    
    NSString *className = classArr[indexPath.row];
    
    UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
    subViewController.title = valueArr[indexPath.row];
    
    [self.navigationController pushViewController:subViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *tempDic = _dataArr[section];
    return tempDic[@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *tempDic = _dataArr[section];
    NSArray *valueArr = tempDic[@"value"];
    return valueArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"com.huozhiyu.mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    NSDictionary *tempDic = _dataArr[indexPath.section];
    NSArray *valueArr = tempDic[@"value"];
    NSArray *classArr = tempDic[@"class"];
    cell.textLabel.text = valueArr[indexPath.row];
    cell.detailTextLabel.text = classArr[indexPath.row];
    
    return cell;
}

#pragma mark - init
- (void)initData
{
    //主页面数据
    _dataArr = @[@{@"title":@"1. 初识KVO",
                   @"value": @[@"Demo1"],
                   @"class": @[@"Demo1ViewController"]},
                 @{@"title":@"2. KVO底层原理",
                   @"value": @[@"Demo2 | 底层原理及过程分析"],
                   @"class": @[@"Demo2ViewController"]},
                 @{@"title":@"3. 自定义KVO",
                   @"value": @[@"Demo3 | 自定义KVO"],
                   @"class": @[@"Demo3ViewController"]},
                 @{@"title":@"4. KVO知识延展",
                   @"value": @[@"Demo4 | 自动销毁监听",
                               @"Demo5 | block封装",
                               @"Demo6 | YY封装KVO"],
                   @"class": @[@"Demo4ViewController",
                               @"Demo5ViewController",
                               @"Demo6ViewController"]}
                 ];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS底层探究 | KVO";
    
    [self initData];
    
    _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mainTableView.sectionHeaderHeight = 10;
    _mainTableView.sectionFooterHeight = 0;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
    [self.view addSubview:_mainTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

@end
