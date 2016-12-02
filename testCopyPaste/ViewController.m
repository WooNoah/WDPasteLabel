//
//  ViewController.m
//  testCopyPaste
//
//  Created by 吴迪 on 16/12/1.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addGestureToImageView];
    
    [self addGestureToLabel];
}

- (void)addGestureToLabel {
    self.lbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.lbl addGestureRecognizer:gesture];
}

- (void)addGestureToImageView {
    self.imgView.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction)];
    [self.imgView addGestureRecognizer:gesture];
}

#pragma mark - 

- (void)tapAction {
    NSLog(@"tapAction");
    
    [self.lbl becomeFirstResponder];
    
    UIMenuController *menuc = [UIMenuController sharedMenuController];
    
    UIMenuItem *selectItem = [[UIMenuItem alloc]initWithTitle:@"SelectAll" action:@selector(selectAction)];
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"copy" action:@selector(copyContent)];
    UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"delete" action:@selector(deleteAction)];
    
    menuc.menuItems = @[selectItem,copyItem,deleteItem];
    [menuc setTargetRect:self.lbl.frame inView:self.view];
    menuc.arrowDirection = UIMenuControllerArrowLeft;
    
    menuc.menuVisible = YES;
    
}

- (void)selectAction {
    NSLog(@"select");
}

- (void)copyContent {
    NSLog(@"copy");
    UIPasteboard *commonPB = [UIPasteboard generalPasteboard];
    commonPB.string = self.lbl.text;
}

- (void)deleteAction {
    NSLog(@"delete");
    UIPasteboard *commonPB = [UIPasteboard generalPasteboard];
    commonPB.string = @"";
}

- (void)longPressAction {
    NSLog(@"longPressAction");
    
    [self.imgView becomeFirstResponder];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"Copy" action:@selector(copyAction)];
//    UIMenuItem *selectItem = [[UIMenuItem alloc]initWithTitle:@"Select" action:@selector(selectAction)];
    menuController.menuItems = @[copyItem];
    [menuController setTargetRect:self.imgView.frame inView:self.view];
    
    [menuController setMenuVisible:YES];
}

///打印存入的数据
- (IBAction)logAction:(id)sender {
    NSLog(@"log Action");
    UIPasteboard *paster = [UIPasteboard generalPasteboard];


    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"粘贴板中的内容" message:paster.string delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"Okay", nil];
    [alert show];
}

//
- (void)copyAction {
    NSLog(@"copy");
    
    UIPasteboard *paster = [UIPasteboard generalPasteboard];
    paster.string = @"Hello pasteboard";
    
}




//必须实现，不然不会显示MenuController
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//必须实现，不然不会显示MenuController
//可以在这里选择需要添加的事件，返回YES
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction) || action == @selector(selectAction) || action == @selector(copyContent) || action == @selector(deleteAction)) {
        return YES;
    }
    
    return NO;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
