//
//  XJTypeWriterTextView.m
//  textviewtest
//
//  Created by 李晓俊 on 2019/5/20.
//  Copyright © 2019 李晓俊. All rights reserved.
//

#import "XJTypeWriterTextView.h"

@interface XJTypeWriterTextView ()
@property (nonatomic,strong) NSTimer *countDownTimer;                      //计时器
@end
@implementation XJTypeWriterTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hasSound = YES;
        self.typewriteTimeInterval = 0.3;
        
         [self addObserver:self forKeyPath:@"contentSize" options: (NSKeyValueObservingOptionNew) context:NULL];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        UITextView *tv = object;
        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
        CGFloat inset = MAX(0, deadSpace/2.0);
        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
    }
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
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
    if (self.content.length <= self.currentIndex) {
        [atimer invalidate];
        atimer = nil;
        
        self.typewriteEffectBlock();
    }else{
        self.currentIndex++;
        NSString *mutStr = [NSString stringWithFormat:@"%@",self.content];
        mutStr = [self.content substringToIndex:self.currentIndex];
        self.textColor = self.typewriteEffectColor;
        self.text = [NSString stringWithFormat:@"%@",mutStr];
        [self scrollRangeToVisible:NSMakeRange(self.text.length, 1)];
        self.hasSound? AudioServicesPlaySystemSound (soundID):AudioServicesPlaySystemSound (0);
    }
}
@end
