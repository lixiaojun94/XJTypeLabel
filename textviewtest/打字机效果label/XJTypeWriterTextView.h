//
//  XJTypeWriterTextView.h
//  textviewtest
//
//  Created by 李晓俊 on 2019/5/20.
//  Copyright © 2019 李晓俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
typedef void (^XJTypewriteEffectBlock)(void);


@interface XJTypeWriterTextView : UITextView
{
    SystemSoundID  soundID;
}
/** Z
 *    设置单个字打印间隔时间，默认 0.3 秒
 */
@property (nonatomic) NSTimeInterval typewriteTimeInterval;

/** Z
 *    开始打印的位置索引，默认为0，即从头开始
 */
@property (nonatomic) int currentIndex;

/** Z
 *    输入字体的颜色
 */
@property (nonatomic, strong) UIColor *typewriteEffectColor;

/** Z
 *    是否有打印的声音,默认为 YES
 */
@property (nonatomic) BOOL hasSound;

/** Z
 *    打印完成后的回调block
 */
@property (nonatomic, copy) XJTypewriteEffectBlock typewriteEffectBlock;

/** Z
 *  开始打印
 */
-(void)startTypewrite;

@property (nonatomic,strong) NSString *content;
@end


