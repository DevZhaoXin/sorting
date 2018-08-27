//
//  UILabel+VerticalAlign.m
//  JieShu
//
//  Created by Mac on 15/7/10.
//  Copyright (c) 2015年 宋. All rights reserved.
//

#import "UILabel+VerticalAlign.h"

@implementation UILabel (VerticalAlign)

-(void)alignTop {
    int newLinesToPad = [self getNewLinesToPad];
    for(int i=0; i<newLinesToPad; i++){
        self.text =[self.text stringByAppendingString:@"\n "];
    }
}

-(void)alignBottom {
    int newLinesToPad = [self getNewLinesToPad];
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}
- (int)getNewLinesToPad{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize fontSize = [self.text sizeWithAttributes:attributes];
    //    [self.text sizeWithFont:self.font];(<=iOS6)
    
    double finalWidth =self.frame.size.width;//expected width of label
    double finalHeight = fontSize.height *self.numberOfLines;
    
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //   [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];(<=iOS6)
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    return newLinesToPad;
}
@end
