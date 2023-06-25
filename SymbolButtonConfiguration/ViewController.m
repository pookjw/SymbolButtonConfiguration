//
//  ViewController.m
//  SymbolButtonConfiguration
//
//  Created by Jinwoo Kim on 6/25/23.
//

#import "ViewController.h"
#import "SymbolButtonConfiguration.h"

@interface ViewController ()
@property (retain) UIButton *button;
@property (assign) BOOL isPlaying;
@end

@implementation ViewController

- (void)dealloc {
    [_button release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    SymbolButtonConfiguration *configuration = [SymbolButtonConfiguration plainButtonConfiguration];
    configuration.image = [UIImage systemImageNamed:@"playpause.fill"];
    
    SymbolButtonConfigurationEffect *effect = [[SymbolButtonConfigurationEffect alloc] initWithSymbolEffect:[NSSymbolBounceEffect bounceUpEffect]
                                                                                                    options:[NSSymbolEffectOptions optionsWithRepeating]
                                                                                                   animated:YES
                                                                                                 completion:nil];
    
    [configuration.sbc_effects addObject:effect];
    
    [effect release];
    
    __block typeof(self) unretained = self;
    UIAction *action = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [unretained updateButton];
    }];
    
    UIButton *button = [UIButton buttonWithConfiguration:configuration primaryAction:action];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [button.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    self.button = button;
}

- (void)updateButton {
    SymbolButtonConfiguration *configuration = [self.button.configuration copy];
    [configuration.sbc_effects removeAllObjects];
    
    NSSymbolContentTransition *transition = [NSSymbolReplaceContentTransition replaceDownUpTransition];
    NSSymbolEffectOptions *options = [NSSymbolEffectOptions optionsWithNonRepeating];
    
    UIImage *image;
    if (self.isPlaying) {
        image = [UIImage systemImageNamed:@"play.fill"];
    } else {
        image = [UIImage systemImageNamed:@"pause.fill"];
    }
    
    configuration.image = image;
    
    SymbolButtonConfigurationTransition *sbc_transition = [[SymbolButtonConfigurationTransition alloc] initWithSymbolImage:image transition:transition options:options completion:nil];
    configuration.sbc_transition = sbc_transition;
    [sbc_transition release];
    
    self.button.configuration = configuration;
    [configuration release];
    
    self.isPlaying = !self.isPlaying;
}

@end

