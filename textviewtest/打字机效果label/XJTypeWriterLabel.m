//
//  XJTypeWriterTextView.m
//  textviewtest
//
//  Created by 李晓俊 on 2019/5/20.
//  Copyright © 2019 李晓俊. All rights reserved.
//
#import "XJTypeWriterLabel.h"
@interface XJTypeWriterLabel ()
@property (nonatomic,strong) NSTimer *countDownTimer;                      //计时器
@end
@implementation XJTypeWriterLabel
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hasSound = YES;
        self.typewriteTimeInterval = 0.3;
    }
    return self;
}

-(void)startTypewrite
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"typewriter" ofType:@"wav"];
        
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    if (_countDownTimer) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        self.currentIndex = 0;
    }
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:self.typewriteTimeInterval target:self selector:@selector(outPutWord:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];

}

-(void)outPutWord:(id)atimer
{
    if (self.text.length <= self.currentIndex) {
        [atimer invalidate];
        atimer = nil;
        
        self.typewriteEffectBlock();
    }else{
        self.currentIndex++;
        NSDictionary *dic = @{NSForegroundColorAttributeName: self.typewriteEffectColor};
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutStr addAttributes:dic range:NSMakeRange(0, self.currentIndex)];
        [self setAttributedText:mutStr];
        
        self.hasSound? AudioServicesPlaySystemSound (soundID):AudioServicesPlaySystemSound (0);
    }
}

@end
