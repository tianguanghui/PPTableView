//
//  ViewController.m
//  PPTableView
//
//  Created by bz on 16/5/4.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "ViewController.h"
#import "PPTableView.h"

@interface ViewController ()
@property (nonatomic, strong) PPTableViewInfo *tableViewInfo;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableViewInfo = [[PPTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Test"];
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:@selector(test:) target:self title:@"Test" accessoryType:UITableViewCellAccessoryNone];
    PPTableViewCellInfo *cellInfo1 = [PPTableViewCellInfo normalCellForSel:@selector(test:) target:self title:@"Test" rightValue:nil imageName:@"" accessoryType:UITableViewCellAccessoryCheckmark];
    [sectionInfo addCell:cellInfo];
    [sectionInfo addCell:cellInfo1];
    [_tableViewInfo addSection:sectionInfo];
    [self.view addSubview:[_tableViewInfo getTableView]];
}

- (UIView *)createSectionView:(PPTableViewSectionInfo *)sectionInfo
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.width)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)test:(PPTableViewCellInfo *)cellinfo
{
    NSLog(@"Test");
}
@end
