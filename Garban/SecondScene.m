//
//  SecondScene.m
//  Garban
//
//  Created by Pablo Formoso Estrada on 07/12/11.
//  Copyright 2011 Pablo Formoso. All rights reserved.
//
#import "MainScene.h"
#import "SecondScene.h"


@implementation SecondScene

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    SecondScene *layer = [SecondScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    self = [super init];
    
    if (self) {
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Yeah!!!!" fontName:@"Marker Felt" fontSize:64];
        CGSize size = [[CCDirector sharedDirector] winSize];
        label.position = ccp(size.width/2, size.height/2);        
        [self addChild:label];
        
        CCMenuItemLabel *backButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Jugar otra" fontName:@"Marker Felt" fontSize:26] block:^(id sender) {
            [self backToMainScene];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(80, 280);
        [self addChild:menu];
    }
    
    return self;
}


- (void)backToMainScene {
    CCScene *trans = [CCTransitionJumpZoom transitionWithDuration:2.0 scene:[MainScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];    
}

- (void) dealloc {
    [super dealloc];
}

@end
