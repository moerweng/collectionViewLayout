//
//  ViewController.m
//  CollectionViewLayout
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import "ViewController.h"

static NSString *title = @"title";
static NSString *vcclass = @"vcclass";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.datas = [NSMutableArray array];
    [_datas addObject:@{title : @"横向分页布局", vcclass : @"WHorizPagingViewController"}];
    [_datas addObject:@{title : @"左侧分组布局", vcclass : @"WSideGroupViewController"}];
}

//MARK: tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    cell.textLabel.text = self.datas[indexPath.row][title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id vc = [NSClassFromString(self.datas[indexPath.row][vcclass]) new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
