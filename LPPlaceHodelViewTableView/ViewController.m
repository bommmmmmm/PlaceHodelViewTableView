//
//  ViewController.m
//  LPPlaceHodelViewTableView
//
//  Created by 刘平 on 2018/1/31.
//  Copyright © 2018年 刘平《 https://github.com/bommmmmmm 》 . All rights reserved.
//

#import "ViewController.h"
#import "LPPlaceHolderViewTableView.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController


#pragma mark lazy loading...
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 150) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

#pragma tableView--delegate
#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*ID=@"CellId";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataArray=[NSMutableArray array];
    [[LPPlaceHolderViewTableView shareNoDataPlacehodelView] showCenterWithSuperView:self.tableView array:self.dataArray iconName:@"图表无数据" viewClicked:^{
        [self addArrayData];
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addArrayData {
    
    [self.dataArray addObject:@"--1-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--2-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--3-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--4-- 有数据源啦！！！！！！"];
    // 需要重指向行触发KVO
    [LPPlaceHolderViewTableView shareNoDataPlacehodelView].NoDataPlacehodelViewDataArray = self.dataArray;
    
}
- (IBAction)addDataButtonAction:(id)sender {
    
    [self addArrayData];
    
}
- (IBAction)deleteDataButtonAction:(id)sender {
    [self.dataArray removeAllObjects];
    // 需要重指向行触发KVO
    [LPPlaceHolderViewTableView shareNoDataPlacehodelView].NoDataPlacehodelViewDataArray = self.dataArray;
//        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
