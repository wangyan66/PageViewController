//
//  WyMessageTableViewViewController.m
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import "WyMessageTableViewViewController.h"
#import "WYMessageTableViewCell.h"
#import "message.h"
@interface WyMessageTableViewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation WyMessageTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpUI];
    [self fakeData];
    // Do any additional setup after loading the view.
}

#pragma mark Init
- (void)SetUpUI{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;

    
    self.tableview.rowHeight =  UITableViewAutomaticDimension;//设置cell的高度为自动计算，只有才xib或者storyboard上自定义的cell才会生效，而且需要设置好约束
    self.tableview.estimatedRowHeight = 100;//必须设置好预估值
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableview];
}
- (void)fakeData{
    
    self.dataArray = [NSMutableArray array];
    NSArray *nameArray = [NSArray arrayWithObjects: @"WERDG",@"有姜姜",@"怕咔咔",@"Sy", nil];
    NSArray *messageArray = [NSArray arrayWithObjects: @"NMDWSM",@"WDNMD",@"给老子移车",@"我想请你海底捞", nil];
    for (int i = 0; i<4; i++) {
        message *msg = [[message alloc]init];
        msg.name = [nameArray objectAtIndex:i];
        msg.message  = [messageArray objectAtIndex:i];
        msg.image = [UIImage imageNamed:@"avatar"];
        msg.time = @"2019年11月11日";
        [self.dataArray addObject:msg];
    }
    
}
#pragma mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"WYMessageTableViewCell";
    WYMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [WYMessageTableViewCell loadCell];
    }
    cell.message = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}
@end
