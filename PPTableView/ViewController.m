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
    [self.view addSubview:[_tableViewInfo getTableView]];
    
    [self createNormalSection];
}

- (void)createNormalSection
{
    PPTableViewCellInfo *normalCellInfo = [PPTableViewCellInfo normalCellForTitle:@"NormalCell" rightValue:@"1"];
    
    PPTableViewCellInfo *normalCellInfo1 = [PPTableViewCellInfo normalCellForTitle:@"NormalCell1" rightValue:@"1" imageName:@"icon"];
    
    PPTableViewCellInfo *normalCellInfo2 = [PPTableViewCellInfo normalCellForSel:@selector(test:) target:self title:@"NormalCell2" accessoryType:UITableViewCellAccessoryCheckmark];
    
    PPTableViewCellInfo *normalCellInfo3 = [PPTableViewCellInfo normalCellForSel:@selector(test:) target:self title:@"NormalCell3" rightValue:@"1" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    PPTableViewCellInfo *normalCellInfo4 = [PPTableViewCellInfo normalCellForSel:@selector(test:) target:self title:@"NormalCell4" rightValue:@"1" imageName:@"icon" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Normal"];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [sectionInfo addCell:normalCellInfo2];
    [sectionInfo addCell:normalCellInfo3];
    [sectionInfo addCell:normalCellInfo4];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)test:(PPTableViewCellInfo *)cellInfo
{
    NSLog(@"Test");
}

@end
