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

+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}

+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:badge accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}

+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue imageName:(NSString *)imageName
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget height:(CGFloat)height userInfo:(PPTableViewUserInfo *)userInfo
{
    PPTableViewCellInfo *cellInfo = [PPTableViewCellInfo cellForMakeSel:makeSel makeTarget:makeTarget actionSel:nil actionTarget:nil height:height userInfo:userInfo];
    cellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    cellInfo.accessoryType = UITableViewCellAccessoryNone;
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget calHeightSel:(SEL)calHeightSel calHeightTarget:(id)calHeightTarget userInfo:(PPTableViewUserInfo *)userInfo
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.calHeightSel = calHeightSel;
    cellInfo.calHeightTarget = calHeightTarget;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(PPTableViewUserInfo *)userInfo
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.fCellHeight = height;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}

+ (instancetype)centerCellForSel:(SEL)sel target:(id)target title:(NSString *)title
{
    PPTableViewCellInfo *cellInfo = [[PPTableViewCellInfo alloc] init];
    cellInfo.makeSel = @selector(makeCenterCell:);
    cellInfo.makeTarget = cellInfo;
    cellInfo.actionSel = sel;
    cellInfo.actionTarget = target;
    cellInfo.fCellHeight = 44.0f;
    cellInfo.accessoryType = UITableViewCellAccessoryNone;
    cellInfo.cellStyle = UITableViewCellStyleDefault;
    [cellInfo addUserInfoValue:title forKey:@"title"];
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
    
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType = _accessoryType;
    cell.backgroundView.hidden = NO;
    
    UIImageView *imageView = nil;
    if (imageName.length) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(15.0f, (cell.frame.size.height - imageView.frame.size.height) * 0.5f, imageView.frame.size.width, imageView.frame.size.height);
        [cell.contentView addSubview:imageView];
    }
    
    UILabel *titleLabel = nil;
    if (title.length) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        if (titleColor) {
            titleLabel.textColor = titleColor;
        } else {
            titleLabel.textColor = [UIColor blackColor];
        }
        if (titleFont) {
            titleLabel.font = titleFont;
        } else {
            titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(15.0f + CGRectGetMaxX(imageView.frame), (cell.frame.size.height - titleLabel.frame.size.height) * 0.5f, titleLabel.frame.size.width, titleLabel.frame.size.height);
        [cell.contentView addSubview:titleLabel];
    }
    
    UILabel *detailLabel = nil;
    if (detail.length) {
        detailLabel = [[UILabel alloc] init];
        detailLabel.text = detail;
        if (detailColor) {
            detailLabel.textColor = detailColor;
        } else {
            detailLabel.textColor = [UIColor grayColor];
        }
        if (detailFont) {
            detailLabel.font = detailFont;
        } else {
            detailLabel.font = [UIFont systemFontOfSize:13.0f];
        }
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [detailLabel sizeToFit];
        detailLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), detailLabel.frame.size.width, detailLabel.frame.size.height);
        [cell.contentView addSubview:detailLabel];
    }
    
    UILabel *rightLabel = nil;
    if (rightValue.length) {
        rightLabel = [[UILabel alloc] init];
        rightLabel.text = rightValue;
        if (rightValueColor) {
            rightLabel.textColor = rightValueColor;
        } else {
            rightLabel.textColor = [UIColor grayColor];
        }
        [rightLabel sizeToFit];
        CGFloat left = [UIScreen mainScreen].bounds.size.width - rightLabel.frame.size.width - 10.0f;
        if (cell.accessoryType != UITableViewCellAccessoryNone) {
            left -= 23.0f;
        }
        rightLabel.frame = CGRectMake(left, 0, rightLabel.frame.size.width, rightLabel.frame.size.height);
        rightLabel.center = CGPointMake(rightLabel.center.x, titleLabel.center.y);
        [cell.contentView addSubview:rightLabel];
    }
    if (leftValue.length) {
//        CGFloat margin = [[self getUserInfoValueForKey:@"fLeftValueMargin"] floatValue];
        if (leftValueColor) {
        }
    }
    NSString *badge = [self getUserInfoValueForKey:@"badge"];
    if (badge.length) {
        PPBadgeView *badgeView = [[PPBadgeView alloc] initWithFrame:CGRectZero];
        [badgeView setString:badge];
        badgeView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 15.0f, 0, badgeView.frame.size.width, badgeView.frame.size.height);
        badgeView.center = CGPointMake(badgeView.center.x, titleLabel.center.y);
        [cell.contentView addSubview:badgeView];
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
        left += [title pp_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:screenWidth maxHeight:CGFLOAT_MAX].width + margin + 15.0f;
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

- (void)makeCenterCell:(UITableViewCell *)cell
{
    NSString *title = [self getUserInfoValueForKey:@"title"];
    cell.textLabel.text = title;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType = _accessoryType;
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

- (void)actionUrlInnerCell
{
    
}

- (void)actionUrlCell
{
    
}
@end
