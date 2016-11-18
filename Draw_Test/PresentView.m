//
//  PresentView.m
//  Draw_Test
//
//  Created by charlie on 2016/10/24.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "PresentView.h"
@interface PresentView (){
    UIView * mainView;
    UIWindow * window;
    UIButton * cancelButton;
    UIView * contentView;

}

@end
@implementation PresentView
-(instancetype)init{
    self = [ super init];
    if (self) {
        window = [[[UIApplication sharedApplication] delegate] window];
        [self setFrame:window.frame];
        self.backgroundColor = [ UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

        mainView = [[UIView alloc]init];
        mainView.backgroundColor = [ UIColor whiteColor];
        mainView.layer.cornerRadius = 7;
        mainView.layer.borderWidth  = 0.5;
        mainView.layer.borderColor = [ UIColor blackColor].CGColor;
        
        cancelButton = [[ UIButton alloc]init];
        [cancelButton setTitle:@"確定" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];

        cancelButton.hidden = YES;
        contentView.hidden = YES;

    }
    return self;
}
-(void)setContentView:(UIView*)view{
    contentView = view;
    
    if (contentView == nil) {
        return;
    }else{
        
        CGRect frame = contentView.frame;
        frame.size.height = frame.size.height + 40;
        [mainView setFrame: frame];
        [cancelButton setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height-40, frame.size.width, 40)];
    }
}

-(void)setMainViewContent{
    cancelButton.hidden = NO;
    contentView.hidden = NO;
    [mainView addSubview:cancelButton];
    [mainView addSubview: contentView];
}
-(void)showView{

    [mainView setFrame:CGRectMake(0, 0, 1, 1)];
    mainView.center = window.center;
    [self addSubview:mainView];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self setContentView:contentView];
        [window addSubview:self];
        mainView.center = window.center;
    } completion:^(BOOL finished) {
        [self setMainViewContent];
    }];
}
-(void)closeView{
    [mainView removeConstraints:mainView.constraints];
    [UIView animateWithDuration:0.2 animations:^{
        [mainView setFrame:CGRectMake(0, 0, 1, 1)];
        mainView.center = window.center;
        mainView.alpha = 0.0;
        [cancelButton removeFromSuperview];
        [contentView removeFromSuperview];
    } completion:^(BOOL finished) {
        [mainView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
-(void)close:(UIButton*)button{
    [self closeView];
}
@end
