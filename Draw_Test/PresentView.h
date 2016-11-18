//
//  PresentView.h
//  Draw_Test
//
//  Created by charlie on 2016/10/24.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentView : UIView
-(instancetype)init;
-(void)setContentView:(UIView*)view;
-(void)showView;
-(void)closeView;
@end
