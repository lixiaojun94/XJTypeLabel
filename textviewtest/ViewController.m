//
//  ViewController.m
//  textviewtest
//
//  Created by 李晓俊 on 2019/5/20.
//  Copyright © 2019 李晓俊. All rights reserved.
//

#import "ViewController.h"
#import "XJTypeWriterLabel.h"
#import "XJTypeWriterTextView.h"

#define kLabelFont [UIFont boldSystemFontOfSize:16]
#define marginLeft 15
#define distanceOfHeadImageWithText 4
#define textEdgeInsetHorizontal 10
#define textEdgeInsetVertical 10

#define maxWidth kMainScreenOfWidth - marginLeft*2 - textEdgeInsetHorizontal*2 - 40

@interface ViewController ()
@property (nonatomic,strong) XJTypeWriterLabel * chatTextLabel;
@property (nonatomic,strong) XJTypeWriterTextView * chatTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _chatTextLabel = [[XJTypeWriterLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    _chatTextLabel.backgroundColor = [UIColor yellowColor];
    _chatTextLabel.font = kLabelFont;
    _chatTextLabel.hasSound = NO;
    _chatTextLabel.numberOfLines = 0;
    _chatTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _chatTextLabel.typewriteEffectColor = [UIColor blackColor];
    _chatTextLabel.textColor = _chatTextLabel.backgroundColor;
    _chatTextLabel.textAlignment = NSTextAlignmentCenter;
    _chatTextLabel.typewriteTimeInterval = 0.1;
//    @weakify(self);
    _chatTextLabel.typewriteEffectBlock = ^(){
//        @strongify(self);
//        [self typeNext];
//        if (App.needLoadCellArray.count == 0) {
//            [CLUserNotificationCenter postNotificationName:kNotificationName_enableClick object:self.model];
//        }
    };
    [self.view addSubview:_chatTextLabel];
    
    _chatTextView = [[XJTypeWriterTextView alloc] initWithFrame:CGRectMake(0, 320, 200, 100)];
    _chatTextView.backgroundColor = [UIColor yellowColor];
    _chatTextView.font = kLabelFont;
    _chatTextView.hasSound = NO;
    _chatTextView.typewriteEffectColor = [UIColor blackColor];
    _chatTextView.textColor = _chatTextLabel.backgroundColor;
    _chatTextView.textAlignment = NSTextAlignmentCenter;
    _chatTextView.typewriteTimeInterval = 0.1;
    _chatTextView.editable = NO;
    //    @weakify(self);
    _chatTextView.typewriteEffectBlock = ^(){
        //        @strongify(self);
        //        [self typeNext];
        //        if (App.needLoadCellArray.count == 0) {
        //            [CLUserNotificationCenter postNotificationName:kNotificationName_enableClick object:self.model];
        //        }
        
    };
    [self.view addSubview:_chatTextView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _chatTextLabel.text = @"这是在项目开发中需要实现的效果，实现文字一个一个输出来的效果可以自定义文字的颜色，间隔时间，开始位置等。实现了UILabel和UITextView都可使用。";
    [_chatTextLabel startTypewrite];


    _chatTextView.content = @"这是在项目开发中需要实现的效果，实现文字一个一个输出来的效果可以自定义文字的颜色，间隔时间，开始位置等。实现了UILabel和UITextView都可使用。";
    [_chatTextView startTypewrite];
}

@end
