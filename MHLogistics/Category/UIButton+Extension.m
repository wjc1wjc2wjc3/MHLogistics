//
//  UIButton+Extension.m
//  HZBitSmartLock
//
//  Created by Apple on 05/12/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "UIButton+Extension.h"

static const char *kCheckSelected       = "CheckSelected";
static const char *kEyeCLosed           = "EyeCLosed";
static const char *kAcceptEventInterval = "acceptEventInterval";

@implementation UIButton (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL beforeSelector = @selector(sendAction:to:forEvent:);
        SEL afterSelector = @selector(lock_sendAction:to:forEvent:);
        Method beforeMethod = class_getInstanceMethod(class, beforeSelector);
        Method afterMethod = class_getInstanceMethod(class, afterSelector);
        BOOL didAddMethod =
        class_addMethod(class,
                        beforeSelector,
                        method_getImplementation(afterMethod),
                        method_getTypeEncoding(afterMethod));
        NSLog(@"%d",didAddMethod);
        if (didAddMethod) {
            class_replaceMethod(class,
                                afterSelector,
                                method_getImplementation(beforeMethod),
                                method_getTypeEncoding(beforeMethod));
        } else {
            
            method_exchangeImplementations(afterMethod, beforeMethod);
        }
    });
    
}

- (void)setBSelected:(BOOL)bSelected {
    objc_setAssociatedObject(self, kCheckSelected, [NSNumber numberWithBool:bSelected], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)bSelected {
    NSNumber *number = objc_getAssociatedObject(self, kCheckSelected);
    return number.boolValue;
}

- (void)setBEyeClosed:(BOOL)bEyeClosed {
    objc_setAssociatedObject(self, kEyeCLosed, [NSNumber numberWithBool:bEyeClosed], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)bEyeClosed {
    NSNumber *number = objc_getAssociatedObject(self, kEyeCLosed);
    return number.boolValue;
}

- (NSTimeInterval)acceptEventInterval {
    NSNumber *number = objc_getAssociatedObject(self, kAcceptEventInterval);
    if (number) {
        return number.floatValue;
    }
    return  0;
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, kAcceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//+ (void)load {
////    const char *className = class_getName(self);
////    DLog(@"className %s", className);
//    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method after    = class_getInstanceMethod(self, @selector(lock_sendAction:to:forEvent:));
//    method_exchangeImplementations(before, after);
//}

- (void)lock_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {

    if (self.acceptEventInterval > 0) {
        if (self.userInteractionEnabled) {

            [self lock_sendAction:action to:target forEvent:event];
        }
        self.userInteractionEnabled = NO;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });

    } else {
        [self lock_sendAction:action to:target forEvent:event];
    }
    
}

@end
