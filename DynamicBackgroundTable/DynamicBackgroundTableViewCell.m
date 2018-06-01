//
//  DynamicBackgroundTableViewCell.m
//  DynamicBackgroundTable
//
//  Created by pro_cookie on 2018/05/31.
//  Copyright © 2018年 pro_cookie. All rights reserved.
//

#import "DynamicBackgroundTableViewCell.h"

@implementation DynamicBackgroundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.clipsToBounds = YES;
        _mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -([UIScreen mainScreen].bounds.size.height/1.7 -250 *([UIScreen mainScreen].bounds.size.height / 667))/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/1.7)];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView  addSubview:_mainImageView];
    }
    return self;
}
- (CGFloat)cellOffset {
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    CGFloat cellOffsetY = centerY - windowCenter.y;
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height *2;
    CGFloat offset =  -offsetDig * ([UIScreen mainScreen].bounds.size.height /1.7 - 250 *([UIScreen mainScreen].bounds.size.height / 667))/2;
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    self.mainImageView.transform = transY;
    return offset;
}

- (void)setPreviewingDelegate:(id<UIViewControllerPreviewingDelegate>)previewingDelegate{
    if (!_previewingDelegate){
        _previewingDelegate = previewingDelegate;
        UIViewController *controller = (UIViewController *)previewingDelegate;
        [controller registerForPreviewingWithDelegate:previewingDelegate sourceView:self.contentView];
    }
    
}


@end
