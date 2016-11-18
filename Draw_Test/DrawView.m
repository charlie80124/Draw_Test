//
//  DrawView.m
//  Draw_Test
//
//  Created by charlie on 2016/10/19.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
-(instancetype)init{
    self = [ super init];
    if(self){
        self.backgroundColor = [ UIColor clearColor];
        self.pointArray = [[NSMutableArray alloc]init];
        self.storeArray = [[NSMutableArray alloc]init];
        self.image = [[ UIImage alloc]init];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.image != nil) {
        CGContextSaveGState(context);
        [self.image drawInRect:rect];
        CGContextRestoreGState(context);
    }

    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    
    for (int i = 0; i < _storeArray.count; i++) {
        NSMutableArray * array = [ _storeArray objectAtIndex:i];
        for(int t =0 ; t < array.count ; t ++){
            if (t == array.count-1) {
                break;
            }
            CGPoint point = [[array objectAtIndex:t]CGPointValue];
            CGPoint point2 = [[array objectAtIndex:t+1]CGPointValue];
            CGContextMoveToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextDrawPath(context, kCGPathStroke);
        }
    }
    
    for (int i = 0; i < _pointArray.count; i++) {
            CGPoint point = [[_pointArray objectAtIndex:i]CGPointValue];
        if (i == _pointArray.count-1) {
            return;
        }
            CGPoint point2 = [[_pointArray objectAtIndex:i+1]CGPointValue];
            CGContextMoveToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextDrawPath(context, kCGPathStroke);
    }
    CGContextRestoreGState(context);

}

-(UIImage*)saveImage{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
