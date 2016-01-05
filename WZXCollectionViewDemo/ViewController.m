//
//  ViewController.m
//  WZXCollectionViewDemo
//
//  Created by wordoor－z on 16/1/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "WZXFallView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    WZXFallView      * _topView;
    UITableView      * _bottomView;
    NSMutableArray   * _topDataArr;
    NSMutableArray   * _bottomDataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self preData];
    [self createTopView];
    [self createMidView];
    [self createBottomView];
}
-(void)preData
{
    NSArray * arr  = @[@"要闻",@"新闻",@"军事",@"社会",@"国际",@"上海",@"瞎扯的",@"我瞎说的啊"];
    _topDataArr    = [[NSMutableArray alloc]init];
    _bottomDataArr = [[NSMutableArray alloc]initWithArray:arr];
}
-(void)createTopView
{
    _topView = [[WZXFallView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, (self.view.frame.size.height - 20)/3.0)];
    
    [self.view addSubview:_topView];
}

-(void)createMidView
{
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 20 + ((self.view.frame.size.height - 20)/3.0), self.view.frame.size.width , 50)];
    midView.backgroundColor =  [UIColor colorWithRed:(100 / 255.0) green:(200/255.0) blue:(300/255.0) alpha:1.0f];
    [self.view addSubview:midView];
    
    UILabel * midLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, midView.frame.size.width - 20, midView.frame.size.height)];
    midLabel.textColor = [UIColor whiteColor];
    midLabel.text      = @"More";
    [midView addSubview:midLabel];
    
}

-(void)createBottomView
{
    _bottomView = [[UITableView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 20)/3.0 + 20 + 50, self.view.frame.size.width, (self.view.frame.size.height - 20)/2.0) style:UITableViewStylePlain];
    _bottomView.delegate   = self;
    _bottomView.dataSource = self;
    [self.view addSubview:_bottomView];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //{top, left, bottom, right};
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = _topDataArr[indexPath.row];
    [_bottomDataArr addObject:str];
    [_topDataArr removeObjectAtIndex:indexPath.row];
    [self upData];
}
#pragma mark -- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bottomDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"MyTableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = _bottomDataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = _bottomDataArr[indexPath.row];
    [_topDataArr addObject:str];
    [_bottomDataArr removeObjectAtIndex:indexPath.row];
    [self upData];
}
-(void)changeTopDataArr:(UIButton *)sender
{
    NSArray * arr = [_topDataArr copy];
    for (int i = 0; i < arr.count; i++)
    {
        NSString * str = arr[i];
        if ([str isEqualToString:sender.titleLabel.text])
        {
            [_topDataArr removeObjectAtIndex:i];
        }
    }
    [_bottomDataArr addObject:sender.titleLabel.text];
    [self upData];
}
//刷新
-(void)upData
{
    [_topView upDataWithArr:_topDataArr];
    for (UIView * view in _topView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton * btn = (UIButton *)view;
            [btn addTarget:self action:@selector(changeTopDataArr:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [_bottomView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
