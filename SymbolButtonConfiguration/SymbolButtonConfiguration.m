//
//  SymbolButtonConfiguration.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/25/23.
//

#import "SymbolButtonConfiguration.h"
#import <objc/message.h>

@implementation SymbolButtonConfigurationEffect

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithSymbolEffect:(NSSymbolEffect *)symbolEffect options:(NSSymbolEffectOptions *)options animated:(BOOL)animated completion:(UISymbolEffectCompletion)completionHandler {
    if (self = [self init]) {
        [self _commonInitWithSymbolEffect:symbolEffect options:options animated:animated completion:completionHandler];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        [self _commonInitWithSymbolEffect:[coder decodeObjectOfClass:NSSymbolEffect.class forKey:@"symbolEffect"]
                                  options:[coder decodeObjectOfClass:NSSymbolEffectOptions.class forKey:@"options"]
                                 animated:[coder decodeBoolForKey:@"animated"]
                               completion:nil];
    }
    
    return self;
}

- (void)_commonInitWithSymbolEffect:(NSSymbolEffect *)symbolEffect options:(NSSymbolEffectOptions *)options animated:(BOOL)animated completion:(UISymbolEffectCompletion _Nullable)completionHandler {
    [_symbolEffect release];
    _symbolEffect = [symbolEffect copy];
    
    [_options release];
    _options = [options copy];
    
    _animated = animated;
    
    [_completion release];
    _completion = [completionHandler copy];
}

- (void)dealloc {
    [_symbolEffect release];
    [_options release];
    [_completion release];
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    NSAssert(_completion == nil, @"Encoding block is not available.");
    
    [coder encodeObject:_symbolEffect forKey:@"symbolEffect"];
    [coder encodeObject:_options forKey:@"options"];
    [coder encodeBool:_animated forKey:@"animated"];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    SymbolButtonConfigurationEffect *copy = [self.class new];
    
    [copy->_symbolEffect release];
    copy->_symbolEffect = [_symbolEffect copyWithZone:zone];
    
    [copy->_options release];
    copy->_options = [_options copyWithZone:zone];
    
    copy->_animated = _animated;
    
    [copy->_completion release];
    copy->_completion = [_completion copyWithZone:zone];
    
    return copy;
}

@end

@implementation SymbolButtonConfigurationTransition

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithSymbolImage:(UIImage *)symbolImage transition:(NSSymbolContentTransition *)transition options:(NSSymbolEffectOptions *)options completion:(UISymbolEffectCompletion)completionHandler {
    if (self = [self init]) {
        [self _commonInitWithSymbolImage:symbolImage transition:transition options:options completion:completionHandler];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        [self _commonInitWithSymbolImage:[coder decodeObjectOfClass:UIImage.class forKey:@"symbolImage"]
                              transition:[coder decodeObjectOfClass:NSSymbolContentTransition.class forKey:@"transition"]
                                 options:[coder decodeObjectOfClass:NSSymbolEffectOptions.class forKey:@"options"]
                              completion:nil];
    }
    
    return self;
}

- (void)dealloc {
    [_symbolImage release];
    [_transition release];
    [_options release];
    [_completion release];
    [super dealloc];
}

- (void)_commonInitWithSymbolImage:(UIImage *)symbolImage transition:(NSSymbolContentTransition *)transition options:(NSSymbolEffectOptions *)options completion:(UISymbolEffectCompletion _Nullable)completionHandler {
    [_symbolImage release];
    _symbolImage = [symbolImage retain];
    
    [_transition release];
    _transition = [transition copy];
    
    [_options release];
    _options = [options copy];
    
    [_completion release];
    _completion = [completionHandler copy];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    NSAssert(_completion == nil, @"Encoding block is not available.");
    
    [coder encodeObject:_symbolImage forKey:@"symbolImage"];
    [coder encodeObject:_transition forKey:@"transition"];
    [coder encodeObject:_options forKey:@"options"];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    SymbolButtonConfigurationTransition *copy = [self.class new];
    
    [copy->_symbolImage release];
    copy->_symbolImage = [_symbolImage retain];
    
    [copy->_transition release];
    copy->_transition = [_transition copyWithZone:zone];
    
    [copy->_options release];
    copy->_options = [_options copyWithZone:zone];
    
    [copy->_completion release];
    copy->_completion = [_completion copyWithZone:zone];
    
    return copy;
}

@end

@implementation SymbolButtonConfiguration

- (instancetype)_initWithBehaviors:(id)arg1 {
    struct objc_super superInfo = { self, [self superclass] };
    ((void (*)(struct objc_super *, SEL, id))objc_msgSendSuper)(&superInfo, @selector(_initWithBehaviors:), arg1);
    
    if (self) {
        [_sbc_effects release];
        _sbc_effects = [NSMutableArray new];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        _sbc_effects = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSMutableArray.class, SymbolButtonConfigurationEffect.class, nil] forKey:@"sbc_effects"];
        _sbc_transition = [coder decodeObjectOfClass:SymbolButtonConfigurationTransition.class forKey:@"sbc_transition"];
    }
    
    return self;
}

- (void)dealloc {
    [_sbc_effects release];
    [_sbc_transition release];
    [super dealloc];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    SymbolButtonConfiguration *copy = [super copyWithZone:zone];
    
    [copy->_sbc_effects release];
    copy->_sbc_effects = [_sbc_effects mutableCopyWithZone:zone];
    
    [copy->_sbc_transition release];
    copy->_sbc_transition = [_sbc_transition copyWithZone:zone];
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:_sbc_effects forKey:@"sbc_effects"];
    [coder encodeObject:_sbc_transition forKey:@"sbc_transition"];
}

@end
