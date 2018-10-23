//
//  CountDownButton.m
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "CountDownButton.h"
@interface CountDownButton(){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@end

@implementation CountDownButton
#pragma -mark touche action
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(CountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    
    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:self->_countDownChanging(self,self->_second) forState:UIControlStateNormal];
                [self setTitle:self->_countDownChanging(self,self->_second) forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setTitle:self->_countDownFinished(self,self->_totalSecond)forState:UIControlStateNormal];
                        [self setTitle:self->_countDownFinished(self,self->_totalSecond)forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!self.bNODrawBottom) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
    }
}

#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}
@end
