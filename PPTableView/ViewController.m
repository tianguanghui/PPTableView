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
    [self createSwitchSection];
    [self createEdtiorSection];
//    int i = 0x2800;
//    float f = *(float *)&i;
////    CGFloat iii = f 
}

- (void)createNormalSection
{
    PPTableViewCellInfo *normalCellInfo = [PPTableViewCellInfo normalCellForTitle:@"NormalCell" rightValue:@"1"];
    
    PPTableViewCellInfo *normalCellInfo1 = [PPTableViewCellInfo normalCellForTitle:@"NormalCell1" rightValue:@"1" imageName:@"icon"];
    
    PPTableViewCellInfo *normalCellInfo2 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell2" accessoryType:UITableViewCellAccessoryCheckmark];
    
    PPTableViewCellInfo *normalCellInfo3 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell3" rightValue:@"1" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    PPTableViewCellInfo *normalCellInfo4 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell4" rightValue:@"1" imageName:@"icon" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [sectionInfo addCell:normalCellInfo2];
    [sectionInfo addCell:normalCellInfo3];
    [sectionInfo addCell:normalCellInfo4];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)createSwitchSection
{
    PPTableViewCellInfo *switchCellInfo = [PPTableViewCellInfo switchCellForSel:@selector(on) target:self title:@"SwitchCell" on:NO];
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Switch"];
    [sectionInfo addCell:switchCellInfo];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)createEdtiorSection
{
    PPTableViewCellInfo *editorCellInfo = [PPTableViewCellInfo editorCellForSel:@selector(text:) target:self tip:@"placeholder" focus:NO text:nil];
    PPTableViewCellInfo *editorCellInfo1 = [PPTableViewCellInfo editorCellForSel:@selector(text:) target:self tip:@"placeholder" focus:NO autoCorrect:YES text:@"AutoCorrect"];
    PPTableViewCellInfo *editorCellInfo2 = [PPTableViewCellInfo editorCellForSel:@selector(text:) target:self title:@"Nickname:" margin:0 tip:@"placeholder" focus:NO text:@"DSKcpp"];
    PPTableViewCellInfo *editorCellInfo3 = [PPTableViewCellInfo editorCellForSel:@selector(text:) target:self title:@"Password:" margin:0 tip:@"placeholder" focus:NO autoCorrect:NO text:nil];
    [editorCellInfo3 addUserInfoValue:@(YES) forKey:@"secureTextEntry"];
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Editor"];
    [sectionInfo addCell:editorCellInfo];
    [sectionInfo addCell:editorCellInfo1];
    [sectionInfo addCell:editorCellInfo2];
    [sectionInfo addCell:editorCellInfo3];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)test
{
    NSLog(@"Test");
}

- (void)on
{
    NSLog(@"On");
}

- (void)text:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}
@end
