#import "MainScene.h"
#import "draftbox.h"

@implementation MainScene{
    CCTransition *_transition;
    CCLayoutBox *columnOne;
    CCLayoutBox *columnTwo;
    int draftcounter;
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
    
    draftcounter = 0;
    
    for (int i = 0; picArray.count > i; i++) {
        draftbox *draftboxicon = [[draftbox alloc]init];
        
        [columnOne addChild:draftboxicon];
        
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
