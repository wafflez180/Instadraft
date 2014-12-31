#import "MainScene.h"
#import "draftbox.h"
#import "EditDraftScene.h"

@implementation MainScene{
    CCTransition *_transition;
    CCLayoutBox *columnOne;
    CCLayoutBox *columnTwo;
    int draftcounter;
    bool leftColumn;
    bool rightColumn;
}

-(void)didLoadFromCCB{
    NSString *rank    = @"0";
    NSDate *lastRead    = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:rank];
    if (lastRead == nil)     // App first run: set up user defaults.
    {
        NSDictionary *appDefaults  = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate date], rank, nil];
        
        // do any other initialization you want to do here - e.g. the starting default values.
        // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"should_play_sounds"];
        
        [MGWU setObject:[NSNumber numberWithBool:YES] forKey:@"sound"];
        [MGWU setObject:[NSNumber numberWithInt:-1] forKey:@"currentDraft"];
        [MGWU setObject:[NSMutableArray arrayWithObjects: nil] forKey:@"PictureArray"];
        [MGWU setObject:[NSMutableArray arrayWithObjects: nil] forKey:@"CaptionArray"];
        
        // sync the defaults to disk
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:rank];
    
    //    [[CCDirector sharedDirector]setDisplayStats:YES];
    
    NSMutableArray *picArray = [MGWU objectForKey:@"PictureArray"];
    NSMutableArray *captionArray = [MGWU objectForKey:@"CaptionArray"];
    
    EditDraftScene *draftscene = [EditDraftScene alloc];
    
    draftscene.name = @"";
    
    draftcounter = 0;
    
    if (picArray.count % 2) {
        leftColumn = true;
    }else{
        leftColumn = false;
    }
    
    for (int i = picArray.count; 0 < i; i--) {
        
        draftbox *draftboxicon = (draftbox*)[CCBReader load:@"DraftBox"];
        draftboxicon.scale = 0.7;
        
        //GET A DRAFTBOX
        
        UIImage *originalImage = [picArray objectAtIndex:i - 1];
        CGSize destinationSize = {150, 150};
        
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //CHANGE THE IMAGE'S SIZE TO 150 pixel BOX
        
        draftboxicon.name = [NSString stringWithFormat:@"%i", i - 1];
        
        CCTexture *texture2D = [[CCTexture alloc] initWithCGImage:newImage.CGImage contentScale:1]; // this is new
        CCSprite9Slice *sprite = [CCSprite9Slice spriteWithTexture:texture2D]; // this is new
        
        [draftboxicon addChild:sprite];
        
        // MAKE A SPRITE FROM THE IMAGE
        
        sprite.positionType = CCPositionTypeNormalized;
        sprite.position = ccp(.50,.50);
        
        if (leftColumn){
            [columnOne addChild:draftboxicon];
            leftColumn = false;
        }else{
            [columnTwo addChild:draftboxicon];
            leftColumn = true;
        }
        
        //CENTER AND ADD THE SPRITE TO THE DRAFTBOX
        
        NSLog(@"draftbox added");
        draftcounter++;
    }
    
    NSLog(@"A total of %i draftbox(s) have been added", draftcounter);
    
}

-(void)newdraft{
    CCScene *EditDraftScene = [CCBReader loadAsScene:@"EditDraftScene"];
    [[CCDirector sharedDirector] replaceScene:EditDraftScene];
}


@end
