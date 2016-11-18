//
//  ViewController.m
//  Draw_Test
//
//  Created by charlie on 2016/10/19.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "PresentView.h"
@interface ViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    NSMutableArray * pointArray ;
    DrawView * drawView;
    UIScrollView * topView ;
    UIButton * colorBtn;
    UIButton * widthBtn;
    UIButton * storeBtn;
    UIButton * clearBtn;
    UIImageView * imageView;
    NSDictionary * colorDic;
    UITapGestureRecognizer * tapG;
    PresentView * presentView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"畫畫";
    self.view.backgroundColor = [ UIColor lightGrayColor];
    [self setObj];
    [self readFromFile];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self saveToFile];
}

-(void)setObj{

    pointArray = [[ NSMutableArray alloc]init];
    drawView = [[ DrawView alloc]init];
    drawView.clearsContextBeforeDrawing = NO;
    topView = [[ UIScrollView alloc]init];
    topView.delegate = self;
    topView.bounces = NO;
    imageView = [[ UIImageView alloc]init];
    imageView.layer.borderColor = [UIColor brownColor].CGColor;
    imageView.userInteractionEnabled = YES;
    imageView.layer.borderWidth = 1;
    tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickPhoto:)];
    [imageView addGestureRecognizer:tapG];
    
    [self.view addSubview:imageView];
    [self.view addSubview:drawView];
    [self.view addSubview:topView];

    colorBtn = [self newbutton];
    [colorBtn setTitle:@"顏色" forState:UIControlStateNormal];
    widthBtn = [self newbutton];
    [widthBtn setTitle:@"寬度" forState:UIControlStateNormal];
    storeBtn = [self newbutton];
    [storeBtn setTitle:@"存檔" forState:UIControlStateNormal];
    clearBtn = [self newbutton];
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];

    NSArray * array = @[colorBtn,widthBtn,storeBtn,clearBtn];
    
    [drawView setFrame:CGRectMake(0, 164, self.view.frame.size.width, self.view.frame.size.height-164)];
    [topView setFrame:CGRectMake(0, 64, self.view.frame.size.width/2, 100)];
    [imageView setFrame:CGRectMake(self.view.frame.size.width/2, 64, self.view.frame.size.width/2, 100)];
    
    for (int i = 0 ; i < array.count; i++) {
        UIButton * btn = [array objectAtIndex:i];
        [btn setFrame:CGRectMake(i * 60 , 0, 60, 100)];
    }
    topView.contentSize = CGSizeMake(array.count*60, 100);
    
    
    
      colorDic = @{@"purple":[UIColor purpleColor],
                   @"red":[UIColor redColor],
                   @"gray":[UIColor grayColor],
                   @"lightGrayColor":[UIColor lightGrayColor],
                   @"green":[UIColor greenColor],
                   @"brown":[UIColor brownColor],
                   @"yellow":[UIColor yellowColor],
                   @"blue":[UIColor blueColor],
                   @"white":[UIColor whiteColor],
                   @"cyan":[UIColor cyanColor],
                   @"orange":[UIColor orangeColor],
                   @"magentaColor":[UIColor magentaColor],
                   };
}

-(UIButton*)newbutton{
    UIButton * btn = [[ UIButton alloc]init];
    btn.backgroundColor = [ UIColor blueColor];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [ UIColor brownColor].CGColor;
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    return btn;
}
-(void)clearDrawView{
    [pointArray removeAllObjects];
    [drawView.pointArray removeAllObjects];
    [drawView.storeArray removeAllObjects];
    imageView.image = nil;
    drawView.image = nil;
    [drawView setNeedsDisplay];

}
-(void)btn:(UIButton*)btn{
    if ([clearBtn isEqual:btn]) {
        [self clearDrawView];
    }else if ([widthBtn isEqual:btn]){

        presentView = [[ PresentView alloc]init];
        UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        contentView.backgroundColor= [ UIColor blueColor];
        [presentView setContentView:contentView];
        [presentView showView];
        
    }else if ([colorBtn isEqual:btn]){
        
        presentView = [[ PresentView alloc]init];
        UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
        contentView.backgroundColor= [ UIColor whiteColor];
        UILabel * label = [[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        label.text = @"顏色";
        label.backgroundColor = [ UIColor blackColor];
        label.textColor = [ UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:label];
        NSLog(@"%lu",(unsigned long)colorDic.count);
        for (int i = 0 ; i < colorDic.count; i++) {
            UIButton * colorButton;
            if(i < 3){
                colorButton = [[UIButton alloc]initWithFrame:CGRectMake(i * 320/3, 50, 320/3, 350/4)];
            }else if (i >= 3 && i <= 5) {
                i = i -3;
                colorButton = [[UIButton alloc]initWithFrame:CGRectMake(i * 320/3, 350/4+50, 320/3, 350/4)];
                i = i +3;
                
            }else if (i >= 6 && i <= 8){
                i =i -6;
                colorButton = [[UIButton alloc]initWithFrame:CGRectMake(i * 320/3, 350/4*2+50, 320/3, 350/4)];
                i =i +6;
                
            }else if (i >= 9){
                i =i -9;
                colorButton = [[UIButton alloc]initWithFrame:CGRectMake(i * 320/3, 350/4*3+50, 320/3, 350/4)];
                i =i +9;
                
            }
            colorButton.titleLabel.numberOfLines = 0;
            [colorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [colorButton setTitle:[[colorDic allKeys]objectAtIndex:i] forState:UIControlStateNormal];
            [colorButton setBackgroundColor:[[colorDic allValues]objectAtIndex:i]];
            [colorButton addTarget:self action:@selector(colorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:colorButton];
        }
        
        [presentView setContentView:contentView];
        [presentView showView];
        
    }else if ([storeBtn isEqual:btn]){
        imageView.image = [drawView saveImage];
        UIImageWriteToSavedPhotosAlbum(imageView.image, self , @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
-(void)pickPhoto:(UITapGestureRecognizer*)tap{

    UIPopoverPresentationController * popover;
    UIImagePickerController * imagePicker = [[ UIImagePickerController alloc]init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    popover = imagePicker.popoverPresentationController;
    popover.sourceRect = tap.view.bounds;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
- (void)image: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo{
    NSLog(@"圖片儲存");
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage * image =[info valueForKey:UIImagePickerControllerOriginalImage];
    imageView.image = image;
    drawView.image = image;
    [drawView setNeedsDisplay];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)colorButtonClick:(UIButton*)button{
    drawView.lineColor = button.backgroundColor;
    [presentView closeView];
}
#pragma mark - 手勢
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [ touches anyObject];
    [pointArray removeAllObjects];
    CGPoint point = [touch locationInView:drawView];
    [pointArray addObject:[NSValue valueWithCGPoint:point]];
    drawView.pointArray = pointArray;
    [drawView setNeedsDisplay];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [ touches anyObject];
    CGPoint point = [touch locationInView:drawView];
    [pointArray addObject:[NSValue valueWithCGPoint:point]];
    drawView.pointArray = pointArray;
    [drawView setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [ touches anyObject];
    CGPoint point = [touch locationInView:drawView];
    [pointArray addObject:[NSValue valueWithCGPoint:point]];
    [drawView.storeArray addObject:[pointArray mutableCopy]]; // 因為 removeallobject 記憶體位置關係 所以要 mutableCopy , 否則會一直加到重複的
    drawView.pointArray = pointArray;
    [drawView setNeedsDisplay];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = [ touches anyObject];

    if (touch.view != drawView) {
        return;
    }


}
#pragma mark - data from plist
-(void)readFromFile{

    NSString * path = [[NSBundle mainBundle]pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString * lineColor = [ dic objectForKey:@"color"];
    NSString * lineWidth = [ dic objectForKey:@"width"];
    drawView.lineWidth = [lineWidth floatValue];
    drawView.lineColor = [self getColor:lineColor];
}
-(void)saveToFile{
 
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary * setDic = [[ NSMutableDictionary alloc]init];
    [setDic setObject:[NSString stringWithFormat:@"%f",drawView.lineWidth] forKey:@"width"];
    NSArray * colorArray = [colorDic allKeysForObject:drawView.lineColor];
    NSString * colorString = [colorArray firstObject];
    [setDic setObject:colorString forKey:@"color"];
    [setDic writeToFile:path atomically:YES];
    
}
-(UIColor*)getColor:(NSString*)colorString{
    UIColor * color = [colorDic objectForKey:colorString];
    return color;
}
-(BOOL)shouldAutorotate{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
