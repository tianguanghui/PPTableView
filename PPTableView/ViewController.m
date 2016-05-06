//
//  ViewController.m
//  PPTableView
//
//  Created by bz on 16/5/4.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "ViewController.h"
#import "PPTableView.h"

@interface ViewController () <PPTableViewInfoDelegate, UITextFieldDelegate>
@property (nonatomic, strong) PPTableViewInfo *tableViewInfo;
@property (nonatomic, weak) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableViewInfo = [[PPTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableViewInfo.delegate = self;
    [self.view addSubview:[_tableViewInfo getTableView]];
    
    [self createNormalSection];
    [self createSwitchSection];
    [self createEdtiorSection];
    [self createBadgeSection];
    [self createCustomSection];
    [self createCenterSection];
}

- (void)createNormalSection
{
    PPTableViewCellInfo *normalCellInfo = [PPTableViewCellInfo normalCellForTitle:@"NormalCell" rightValue:@"1"];
    
    PPTableViewCellInfo *normalCellInfo1 = [PPTableViewCellInfo normalCellForTitle:@"NormalCell1" rightValue:@"1" imageName:@"testImage"];
    
    PPTableViewCellInfo *normalCellInfo2 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell2" accessoryType:UITableViewCellAccessoryCheckmark];
    
    PPTableViewCellInfo *normalCellInfo3 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell3" rightValue:@"1" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    PPTableViewCellInfo *normalCellInfo4 = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell4" rightValue:@"1" imageName:@"testImage" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
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
    PPTableViewCellInfo *editorCellInfo = [PPTableViewCellInfo editorCellForSel:@selector(textFieldReturn:) target:self tip:@"placeholder" focus:NO text:nil];
    
    PPTableViewCellInfo *editorCellInfo1 = [PPTableViewCellInfo editorCellForSel:@selector(textFieldReturn:) target:self tip:@"placeholder" focus:NO autoCorrect:YES text:@"AutoCorrect"];
    
    PPTableViewCellInfo *editorCellInfo2 = [PPTableViewCellInfo editorCellForSel:@selector(textFieldReturn:) target:self title:@"Nickname:" margin:0 tip:@"placeholder" focus:NO text:@"DSKcpp"];
    
    PPTableViewCellInfo *editorCellInfo3 = [PPTableViewCellInfo editorCellForSel:@selector(textFieldReturn:) target:self title:@"Password:" margin:0 tip:@"placeholder" focus:NO autoCorrect:NO text:nil];
    [editorCellInfo3 addUserInfoValue:@(YES) forKey:@"secureTextEntry"];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Editor"];
    [sectionInfo addCell:editorCellInfo];
    [sectionInfo addCell:editorCellInfo1];
    [sectionInfo addCell:editorCellInfo2];
    [sectionInfo addCell:editorCellInfo3];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)createBadgeSection
{
    PPTableViewCellInfo *badgeCellInfo = [PPTableViewCellInfo badgeCellForSel:@selector(test) target:self title:@"Message" badge:@"99"];
    
    PPTableViewCellInfo *badgeCellInfo1 = [PPTableViewCellInfo badgeCellForSel:@selector(test) target:self title:@"Friend" badge:@"20" rightValue:@"DSKcpp"];
    
    PPTableViewCellInfo *badgeCellInfo2 = [PPTableViewCellInfo badgeCellForSel:@selector(test) target:self title:@"Title" badge:@"New" rightValue:@"Demo" imageName:@"testImage"];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Badge Header" footer:@"Badge Footer"];
    [sectionInfo addCell:badgeCellInfo];
    [sectionInfo addCell:badgeCellInfo1];
    [sectionInfo addCell:badgeCellInfo2];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)createCustomSection
{
    PPTableViewUserInfo *userInfo = [[PPTableViewUserInfo alloc] init];
    [userInfo addUserInfoValue:@"testImage" forKey:@"imageName"];
    [userInfo addUserInfoValue:@"Custom Cell" forKey:@"title"];
    PPTableViewCellInfo *customCellInfo = [PPTableViewCellInfo cellForMakeSel:@selector(makeCustomCell:cellInfo:) makeTarget:self height:50.0f userInfo:userInfo];
    
    PPTableViewCellInfo *customCellInfo1 = [PPTableViewCellInfo cellForMakeSel:@selector(makeCustomCell:cellInfo:) makeTarget:self actionSel:@selector(test) actionTarget:self height:65.0f userInfo:userInfo];
    
    PPTableViewCellInfo *customCellInfo2 = [PPTableViewCellInfo cellForMakeSel:@selector(makeCustomCell:cellInfo:) makeTarget:self actionSel:@selector(test) actionTarget:self calHeightSel:@selector(calCustinHeight:) calHeightTarget:self userInfo:userInfo];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeaderWithView:[self makeCustomHeaderView]];
    [sectionInfo addCell:customCellInfo];
    [sectionInfo addCell:customCellInfo1];
    [sectionInfo addCell:customCellInfo2];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)createCenterSection
{
    PPTableViewCellInfo *centerCellInfo = [PPTableViewCellInfo centerCellForSel:@selector(test) target:self title:@"Center"];
    
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoHeader:@"Center"];
    [sectionInfo addCell:centerCellInfo];
    [_tableViewInfo addSection:sectionInfo];
}

- (void)makeCustomCell:(UITableViewCell *)cell cellInfo:(PPTableViewCellInfo *)cellInfo
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, cellInfo.fCellHeight, cellInfo.fCellHeight)];
    imageView.image = [UIImage imageNamed:[cellInfo.userInfo getUserInfoValueForKey:@"imageName"]];
    [cell.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cellInfo.fCellHeight + 20, 10, cell.frame.size.width, cellInfo.fCellHeight)];
    label.text = [cellInfo.userInfo getUserInfoValueForKey:@"title"];
    label.textColor = [UIColor blueColor];
    [cell.contentView addSubview:label];
}

- (UIView *)makeCustomHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50.0f)];
    headerView.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"Custom Header" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(40, 5, self.view.frame.size.width - 80, 40.0f);
    [headerView addSubview:button];
    return headerView;
}

- (void)calCustinHeight:(PPTableViewCellInfo *)cellInfo
{
    cellInfo.fCellHeight = 88.0f;
}

- (void)test
{
    NSLog(@"Test");
}

- (void)on
{
    NSLog(@"On");
}

- (void)textFieldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textField = textField;
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_textField.isFirstResponder) {
        [_textField resignFirstResponder];
    }
}

@end
