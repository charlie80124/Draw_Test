//
//  DrawView.h
//  Draw_Test
//
//  Created by charlie on 2016/10/19.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic)UIColor * lineColor;
@property (nonatomic)CGFloat lineWidth;
@property (nonatomic)UIImage * image;
-(UIImage*)saveImage;
@property (nonatomic)NSMutableArray * pointArray;
@property (nonatomic , strong)NSMutableArray * storeArray;
@end
