//
//  WDPasteLabel.m
//  testCopyPaste
//
//  Created by 吴迪 on 16/12/1.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "WDPasteLabel.h"

@implementation WDPasteLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpMenuController];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpMenuController];
}


- (void)setUpMenuController {
    //下面来回顾一下 想要实现MenuController 和 UIPasteboard 需要什么流程
    //1 需要打开用户交互
    self.userInteractionEnabled = YES;
    
    //2.添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction)];
    [self addGestureRecognizer:longPress];
}

- (void)longPressAction {
    //使本身能够成为第一响应者  //必须要实现，不然MenuController不能显示
    [self becomeFirstResponder];
    
    //创建MenuController ，单例
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    //要显示的内容,每一个都是UIMenuItem
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction)];
    
    UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"删除（仅LOG测试）" action:@selector(deleteAction)];
    //设置要显示的内容，为数组
    menuController.menuItems = @[copyItem,deleteItem];
    
    //设置frame和显示到哪里 第一个参数：frame, 第二个，显示到哪里
    [menuController setTargetRect:self.frame inView:[self superview]];
    //设置箭头的方向
    menuController.arrowDirection = UIMenuControllerArrowRight;
    //是这个Menu显现出来
    menuController.menuVisible = YES;
    
}

#pragma mark - Event response
- (void)copyAction {
    //复制操作
    
    //单例 创建 粘贴板
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
    
}

- (void)deleteAction {
    //删除操作
    
    NSLog(@"删除按钮点击了");
}


#pragma mark -

//override 父类的方法， 使该label可以成为第一响应者
//该方法必须实现。
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//该方法必须实现。
/*
 UIResponder — Responders implement the canPerformAction:withSender: to enable or disable commands in the above-mentioned menu based on the current context.
 */

//可以在该方法里判断是否能传递实现方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction) || action == @selector(deleteAction)) {
        return YES;
    }
    return NO;
}


@end
