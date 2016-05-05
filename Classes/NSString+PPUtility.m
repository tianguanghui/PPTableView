//
//  NSString+PPUtility.m
//  PPTableView
//
//  Created by bz on 16/5/5.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "NSString+PPUtility.h"

@implementation NSString (PPUtility)
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    if (self.length) {
        NSDictionary *attributes = @{NSFontAttributeName : font};
        CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
        return [self boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil].size;
    } else {
        return CGSizeZero;
    }
}
@end
