//
//  HelloWorldLayer.m
//  Garban
//
//  Created by Pablo Formoso Estrada on 07/12/11.
//  Copyright Pablo Formoso 2011. All rights reserved.
//

#import "MainScene.h"
#import "SecondScene.h"

// MainScene implementation
@implementation MainScene

@synthesize movement;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	MainScene *layer = [MainScene node];
	
	[scene addChild: layer];
	
	return scene;
}


-(id) init {
    
    self = [super init];
    
	if (self) {
		
        score = 0;
        jumping = NO;
        
        // Background
        CCSprite *bg = [CCSprite spriteWithFile:@"bg_1_1024x2048.png"];
        [bg setPosition:ccp(240, 160)];
        [self addChild:bg];
        
        // Jump Button
        CCMenuItemImage *button = [CCMenuItemImage itemFromNormalImage:@"btnjump_normal.png" 
                                                         selectedImage:@"btnjump_pressed.png" block:^(id sender) {
                                                             [self jumpOnTrampoline];
                                                         }];
        
        CCMenu *menu = [CCMenu menuWithItems:button, nil];
        menu.position = ccp(445,160);
        [self addChild:menu];
        
        // Scoring Label
        label = [CCLabelTTF labelWithString:@"Ganas con 3 saltos!" fontName:@"Helvetica Neue" fontSize:32];
        label.position = ccp(240, 290);
        [self addChild:label];
        
        // Monkey sprite
        monkey2 = [CCSprite spriteWithFile:@"monkey_walk_left_1.png"];
        monkey2.position = ccp(400,70);
        monkey2.flipX = NO;
        [self addChild:monkey2];
        
        // Monkey movement oo going and come 1 time
        self.movement = [CCSequence actions:
                       [CCMoveBy actionWithDuration:2.0 position:ccp(-320, 0)],
                       [CCCallBlock actionWithBlock:^ {
                            monkey2.flipX = YES;
                        }],
                       [CCMoveBy actionWithDuration:2.0 position:ccp(320, 0)],
                       [CCCallBlock actionWithBlock:^ {
                            monkey2.flipX = NO;
                       }]
                       , nil];
        
        // Monkey Sprite animation
        id animation = [CCAnimation animationWithFrames:
                        [NSArray arrayWithObjects:
                         [[CCSprite spriteWithFile:@"monkey_walk_left_1.png"] displayedFrame], 
                         [[CCSprite spriteWithFile:@"monkey_walk_left_2.png"] displayedFrame],
                         [[CCSprite spriteWithFile:@"monkey_jump_left.png"] displayedFrame],
                         nil]];
        
        // Start animating the monkey
        [monkey2 runAction:
         [CCRepeatForever actionWithAction:
          [CCAnimate actionWithDuration:0.35 animation:animation restoreOriginalFrame:NO]
          ]
         ];
        
        // Start moving the monkey across screen
        [monkey2 runAction:
         [CCRepeatForever actionWithAction:self.movement]
        ];
        
	}
	return self;
}

#pragma Some actions

// Load the Secondscene
- (void)nextScene {
    CCScene *trans = [CCTransitionSplitRows transitionWithDuration:2.0 scene:[SecondScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

// Called when jump button is tapped
- (void)jumpOnTrampoline {
    if ((monkey2.position.x >= 120) && (monkey2.position.x <= 160) && !jumping) {        
        jumping = YES;
        
        [monkey2 stopAction:self.movement];
        
        // jump action
        [monkey2 runAction:
         [CCSequence actions:
          [CCJumpBy actionWithDuration:1.0 position:ccp(0, 400) height:400.0 jumps:1],
          [CCCallBlock actionWithBlock:^(void) {
             monkey2.position = ccp(400, 70);
             monkey2.flipX = NO;
             [monkey2 runAction:self.movement];
             jumping = NO;
          }],
          nil]
         ];
        
        score++;
        [label setString:[NSString stringWithFormat:@"%i puntos!", score]];   
        
        if (score == 3) {
            [self nextScene];
        }
        
    } else {
        score--;
        [label setString:[NSString stringWithFormat:@"%i puntos!", score]];
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
    label = nil;
    monkey2 = nil;
	movement = nil;
    
	[super dealloc];
}
@end
