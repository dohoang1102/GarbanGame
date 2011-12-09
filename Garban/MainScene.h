//
//  MainScene.h
//  Garban
//
//  Created by Pablo Formoso Estrada on 07/12/11.
//  Copyright Pablo Formoso 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface MainScene : CCLayer
{
    CCSprite *monkey2;
    CCLabelTTF *label;
    
    int score;
    
    BOOL jumping;
    
    
}

@property (nonatomic, retain) id movement;

// returns a CCScene that contains the MainScene as the only child
+(CCScene *) scene;

- (void)jumpOnTrampoline;
- (void)nextScene;

@end
