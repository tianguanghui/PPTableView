//
//  PPTableViewCellInfo.m
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewCellInfo.h"
#import "PPUtility.h"

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

+ (instancetype)switchCellForSel:(SEL)sel target:(id)target title:(NSString *)title on:(BOOL)on
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeSwitchCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTargetForSwitchCell:target];
    [cellInfo setFCellHeight:44.0f];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cellInfo setAccessoryType:UITableViewCellAccessoryNone];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:@(on) forKey:@"on"];
    return cellInfo;
}

+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text
{
    return [PPTableViewCellInfo editorCellForSel:sel target:target title:nil margin:0 tip:tip focus:focus text:text];
}

+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text
{
    return [PPTableViewCellInfo editorCellForSel:sel target:target title:nil margin:0 tip:tip focus:focus autoCorrect:autoCorrect text:text];
}

+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text
{
    return [PPTableViewCellInfo editorCellForSel:sel target:target title:title margin:margin tip:tip focus:focus autoCorrect:NO text:text];
}

+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeEditorCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTarget:target];
    [cellInfo setFCellHeight:44.0f];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cellInfo setAccessoryType:UITableViewCellAccessoryNone];
    UITextAutocorrectionType autocorrectionType = UITextAutocorrectionTypeNo;
    if (autoCorrect) {
        autocorrectionType = UITextAutocorrectionTypeYes;
    }
    [cellInfo setAutoCorrectionType:autocorrectionType];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:tip forKey:@"tip"];
    [cellInfo addUserInfoValue:text forKey:@"text"];
    [cellInfo addUserInfoValue:@(margin) forKey:@"fEditorLMargin"];
    [cellInfo addUserInfoValue:@(focus) forKey:@"focus"];
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
        PPCPLabel *leftLabel = [[PPCPLabel alloc] init];
        if (leftValueColor) {
            
        }
    }
    if (imageName.length) {
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)makeSwitchCell:(UITableViewCell *)cell
{
    [self makeNormalCell:cell];
    BOOL on = [[self getUserInfoValueForKey:@"on"] boolValue];
    UISwitch *switchView = [[UISwitch alloc] init];
    [cell setAccessoryView:switchView];
    [switchView addTarget:self action:@selector(actionSwitchCell:) forControlEvents:UIControlEventValueChanged];
    [switchView addTarget:_actionTargetForSwitchCell action:_actionSel forControlEvents:UIControlEventValueChanged];
    [switchView setOn:on];
    [self addUserInfoValue:switchView forKey:@"switch"];
}

- (void)makeEditorCell:(UITableViewCell *)cell
{
    NSString *title = [self getUserInfoValueForKey:@"title"];
    NSString *text = [self getUserInfoValueForKey:@"text"];
    NSString *tip = [self getUserInfoValueForKey:@"tip"];
    BOOL focus = [[self getUserInfoValueForKey:@"focus"] boolValue];
    BOOL secureTextEntry = [[self getUserInfoValueForKey:@"secureTextEntry"] boolValue];
    UIKeyboardType keyboardType = [[self getUserInfoValueForKey:@"keyboardType"] integerValue];
    CGFloat margin = [[self getUserInfoValueForKey:@"fEditorLMargin"] floatValue];
    
    CGFloat left = 15.0f;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (title.length) {
        cell.textLabel.text = title;
        left += [title sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:screenWidth maxHeight:CGFLOAT_MAX].width + margin + 15.0f;
    }
    CGRect textFieldFrame = CGRectMake(left, 0, screenWidth - left, cell.bounds.size.height);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.borderStyle = UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = keyboardType;
    textField.autocorrectionType = _autoCorrectionType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.enablesReturnKeyAutomatically = YES;
    textField.secureTextEntry = secureTextEntry;
    if ([_actionTarget conformsToProtocol:@protocol(UITextFieldDelegate)]) {
        textField.delegate = _actionTarget;
    }
    [textField addTarget:self action:@selector(actionEditorCell:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:_actionTarget action:_actionSel forControlEvents:UIControlEventEditingDidEndOnExit];
    textField.text = text;
    textField.placeholder = tip;
    if (focus) {
        [textField becomeFirstResponder];
    }
    [cell.contentView addSubview:textField];
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType = _accessoryType;
    [self addUserInfoValue:textField forKey:@"editor"];
}

- (void)actionSwitchCell:(UISwitch *)switchView
{
    [self addUserInfoValue:@(switchView.isOn) forKey:@"on"];
}

- (void)actionEditorCell:(UITextField *)textField
{
    if (textField.text.length) {
        [self addUserInfoValue:textField.text forKey:@"text"];
    } else {
        [self addUserInfoValue:@"" forKey:@"text"];
    }
}

@end
