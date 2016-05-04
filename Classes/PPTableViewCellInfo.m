//
//  PPTableViewCellInfo.m
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewCellInfo.h"

@implementation PPTableViewCellInfo

- (instancetype)init
{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.editStyle = UITableViewCellEditingStyleNone;
        self.autoCorrectionType = UITextAutocorrectionTypeYes;
        self.cellStyle = UITableViewCellStyleValue1;
    }
    return self;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:nil target:nil title:title rightValue:rightValue accessoryType:0];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cellInfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForTitle:title rightValue:rightValue];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    return [PPTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:accessoryType];
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:accessoryType];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeNormalCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTarget:target];
    [cellInfo setFCellHeight:44.0f];
    [cellInfo setAccessoryType:accessoryType];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:rightValue forKey:@"rightValue"];
    return cellInfo;
}

- (void)makeNormalCell:(UITableViewCell *)cell
{
    NSString *title = [self getUserInfoValueForKey:@"title"];
    UIColor *titleColor = [self getUserInfoValueForKey:@"titleColor"];
    UIFont *titleFont = [self getUserInfoValueForKey:@"titleFont"];
    NSString *detail = [self getUserInfoValueForKey:@"detail"];
    UIColor *detailColor = [self getUserInfoValueForKey:@"detailColor"];
    UIFont *detailFont = [self getUserInfoValueForKey:@"detailFont"];
    NSString *rightValue = [self getUserInfoValueForKey:@"rightValue"];
    UIColor *rightValueColor = [self getUserInfoValueForKey:@"rightValueColor"];
    NSString *leftValue = [self getUserInfoValueForKey:@"leftValue"];
    UIColor *leftValueColor = [self getUserInfoValueForKey:@"leftValueColor"];
    NSString *imageName = [self getUserInfoValueForKey:@"imageName"];
    
    [cell setSelectionStyle:_selectionStyle];
    [cell setAccessoryType:_accessoryType];
    [cell.backgroundView setHidden:NO];
    if (title.length) {
        cell.textLabel.text = title;
        if (titleColor) {
            cell.textLabel.textColor = titleColor;
        }
        if (titleFont) {
            cell.textLabel.font = titleFont;
        }
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (detail.length) {
        cell.detailTextLabel.text = detail;
        if (detailColor) {
            cell.detailTextLabel.textColor = detailColor;
        }
        if (detailFont) {
            cell.detailTextLabel.font = detailFont;
        }
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (rightValue.length) {
        if (rightValueColor) {
            
        }
    }
    if (leftValue.length) {
        if (leftValueColor) {
            
        }
    }
    if (imageName.length) {
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
}

@end
