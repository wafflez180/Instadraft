//
//  draftbox.m
//  instadraft
//
//  Created by Arthur Araujo on 12/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "draftbox.h"
#import "EditDraftScene.h"

@implementation draftbox{
    int indexedArray;
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = true;
}

-(void)GoToDraft{
    EditDraftScene *draftscene = [EditDraftScene alloc];
    
    draftscene.name = self.name;
    
    CCScene *theEditDraftScene = [CCBReader loadAsScene:@"EditDraftScene"];
    [[CCDirector sharedDirector] replaceScene:theEditDraftScene];
}

@end
