//
//  WZXFallView.m
//  WZXCollectionViewDemo
//
//  Created by wordoor－z on 16/1/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXFallView.h"
#define Height 40
@implementation WZXFallView
{
    NSMutableArray * _arr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)upDataWithArr:(NSArray *)arr
{
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSMutableArray * dataArr = [[NSMutableArray alloc]initWithArray:arr];
    CGFloat nowWidth  = 10;
    CGFloat nowHeight = 0;
    while (dataArr.count > 0)
    {
        for (int i = 0; i < dataArr.count; i++)
        {
            NSString * str     = dataArr[i];
            CGFloat labelWidth = [self boundingRectWithStr:str] + 50;
            
            if (self.frame.size.width > nowWidth + labelWidth)
            {
                [self createLabelWithRect:CGRectMake(nowWidth, nowHeight, labelWidth, Height) andTitle:str];
                [dataArr removeObjectAtIndex:i];
                nowWidth += labelWidth + 20;
            }
            else
            {
                for (int j = 0; j < dataArr.count; i++)
                {
                    CGFloat elseWidth = [self boundingRectWithStr:dataArr[j]] + 50;
                    if (self.frame.size.width > nowWidth + elseWidth)
                    {
                        [self createLabelWithRect:CGRectMake(nowWidth, nowHeight, elseWidth, Height) andTitle:dataArr[j]];
                        [dataArr removeObjectAtIndex:j];
                        nowWidth += elseWidth + 20;
                    }
                    else
                    {
                        nowHeight += Height + 10;
                        nowWidth = 10;
                    }
                }
            }
        }
    }
}
-(void)createLabelWithRect:(CGRect)rect andTitle:(NSString *)str
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame               = rect;
    btn.backgroundColor     = [UIColor whiteColor];
    btn.layer.shadowColor   = [UIColor grayColor].CGColor;
    btn.layer.shadowOffset  = CGSizeMake(0.5, 0.5);
    btn.layer.shadowOpacity = 0.8;
    btn.layer.shadowRadius  = 5;
    
    [self addSubview:btn];
}

//计算label宽度
- (CGFloat)boundingRectWithStr:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, Height)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.width;
}
@end
