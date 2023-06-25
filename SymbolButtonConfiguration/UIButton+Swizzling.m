//
//  UIButton+Swizzling.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/25/23.
//

#import "UIButton+Swizzling.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <OSLog/OSLog.h>
#import "SymbolButtonConfiguration.h"

static void (*original_updateImageViewWithConfiguration)(id, SEL, UIButtonConfiguration *);

static void custom_updateImageViewWithConfiguration(id self, SEL _cmd, UIButtonConfiguration *configuration) {
    if (@available(iOS 17.0, tvOS 17.0, watchOS 10.0, *)) {
        if ([configuration isKindOfClass:SymbolButtonConfiguration.class]) {
            SymbolButtonConfiguration *_configuration = (SymbolButtonConfiguration *)configuration;
            
            UIImageView *imageView = ((UIImageView * (*)(id, SEL, BOOL))objc_msgSend)(self, NSSelectorFromString(@"imageViewCreateIfNeeded:"), NO);
            
            [imageView removeAllSymbolEffects];
            [_configuration.sbc_effects enumerateObjectsUsingBlock:^(SymbolButtonConfigurationEffect * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [imageView addSymbolEffect:obj.symbolEffect options:obj.options animated:obj.animated completion:obj.completion];
            }];
            
            SymbolButtonConfigurationTransition * _Nullable transition = _configuration.sbc_transition;
            if (transition) {
                if (![transition.symbolImage isEqual:configuration.image]) {
                    os_log_info(OS_LOG_DEFAULT, "-[SymbolButtonConfigurationTransition symbolImage] is not equivalent to -[SymbolButtonConfiguration image]. It will lead to unexpected behavior.");
                    configuration.image = transition.symbolImage;
                }
                
                if (![transition.symbolImage isEqual:imageView.image]) {
                    UIButton *button = ((UIButton * (*)(id, SEL))objc_msgSend)(self, NSSelectorFromString(@"button"));
                    
                    [imageView setSymbolImage:transition.symbolImage
                        withContentTransition:transition.transition
                                      options:transition.options
                                   completion:^(UISymbolEffectCompletionContext *context) {
                        if (context.isFinished && [button.configuration isEqual:_configuration]) {
                            original_updateImageViewWithConfiguration(self, _cmd, _configuration);
                        }
                        
                        if (transition.completion) {
                            transition.completion(context);
                        }
                    }];
                }
            } else {
                original_updateImageViewWithConfiguration(self, _cmd, configuration);
            }
        } else {
            original_updateImageViewWithConfiguration(self, _cmd, configuration);
        }
    } else {
        original_updateImageViewWithConfiguration(self, _cmd, configuration);
    }
}

@implementation UIButton (Swizzling)

+ (void)load {
    Method method = class_getInstanceMethod(NSClassFromString(@"UIButtonConfigurationVisualProvider"), NSSelectorFromString(@"_updateImageViewWithConfiguration:"));
    original_updateImageViewWithConfiguration = (void (*)(id, SEL, UIButtonConfiguration *))method_getImplementation(method);
    method_setImplementation(method, (IMP)custom_updateImageViewWithConfiguration);
}

@end
