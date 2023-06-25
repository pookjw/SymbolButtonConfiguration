//
//  SymbolButtonConfiguration.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/25/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(17.0),tvos(17.0),watchos(10.0))
@interface SymbolButtonConfigurationEffect : NSObject <NSCopying, NSSecureCoding>
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSymbolEffect:(NSSymbolEffect *)symbolEffect options:(NSSymbolEffectOptions * _Nullable)options animated:(BOOL)animated completion:(UISymbolEffectCompletion _Nullable)completionHandler;
@property (copy, readonly) NSSymbolEffect *symbolEffect;
@property (copy, nullable, readonly) NSSymbolEffectOptions *options;
@property (assign, readonly) BOOL animated;

/// Coding is not available for this object; attempting to code it with a non-null value will throw an exception.
@property (copy, nullable) UISymbolEffectCompletion completion;
@end

API_AVAILABLE(ios(17.0),tvos(17.0),watchos(10.0))
@interface SymbolButtonConfigurationTransition : NSObject <NSCopying>
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSymbolImage:(UIImage *)symbolImage transition:(NSSymbolContentTransition *)transition options:(NSSymbolEffectOptions * _Nullable)options completion:(UISymbolEffectCompletion _Nullable)completionHandler;
@property (retain, readonly) UIImage *symbolImage;
@property (copy, readonly) NSSymbolContentTransition *transition;
@property (copy, nullable, readonly) NSSymbolEffectOptions *options;

/// Coding is not available for this object; attempting to code it with a non-null value will throw an exception.
@property (copy, nullable, readonly) UISymbolEffectCompletion completion;
@end

API_AVAILABLE(ios(17.0),tvos(17.0),watchos(10.0))
@interface SymbolButtonConfiguration : UIButtonConfiguration
@property (retain, readonly) NSMutableArray<SymbolButtonConfigurationEffect *> *sbc_effects;
@property (retain, nullable, nonatomic, setter=set_sbc_transition:) SymbolButtonConfigurationTransition *sbc_transition;
@end

NS_ASSUME_NONNULL_END
