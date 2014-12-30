//
//  EditDraftScene.m
//  instadraft
//
//  Created by Arthur Araujo on 12/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EditDraftScene.h"
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation EditDraftScene{
    CCTransition *_transition;
    CCSprite9Slice *placeholderPhoto;
    CCNode *photoContainer;
    CCAppDelegate *app;
    UIImage *oldImage;
    NSString *inputedCaption;
    UIImage *inputedImage;
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = true;
    
    inputedCaption = @"";
    
    app = [AppController alloc].app;
    
    self.picker = [[UIImagePickerController alloc] init];
    
    app = (AppController*)[[UIApplication sharedApplication] delegate];
    
    // Don't forget to add UIImagePickerControllerDelegate in your .h
    
    
    self.picker.delegate = self;
    
    self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
}

-(void)backtohome{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}

-(void)uploadphoto{
    NSLog(@"Touched to input photo");
    
    [app.navController presentModalViewController:self.picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        
        if (editedImage) {
            
            imageToUse = editedImage;
            
        } else {
            
            imageToUse = originalImage;
            
        }
        
        // Do something with imageToUse, apparently you cannot pass nil as the key
        
        CCTexture *texture2D = [[CCTexture alloc] initWithCGImage:imageToUse.CGImage contentScale:1]; // this is new
        CCSprite9Slice *sprite = [CCSprite9Slice spriteWithTexture:texture2D]; // this is new
        
        [photoContainer addChild:sprite];
        
        sprite.scale = 0;
        sprite.positionType = CCPositionTypeNormalized;
        sprite.position = ccp(.50,.50);
        
        float maxPicHeight = photoContainer.contentSizeInPoints.height;
        float maxPicWidth = photoContainer.contentSizeInPoints.width;
        // GET HEIGHT AND LENGTH DISPLAY RESTRAINTS
        
        while (maxPicHeight >= sprite.contentSizeInPoints.height * sprite.scale){
            sprite.scale = sprite.scale + 0.01;
            //Make it bigger untill it reaches the maxheight
        }
        while (maxPicWidth <= sprite.contentSizeInPoints.width * sprite.scale){
            sprite.scale = sprite.scale - 0.01;
            //if it is too wide than make it smaller
        }
        
        inputedImage = imageToUse;
        
        //CONFIGURE THE IMAGE SCALE TO THE RESTRAINED MAX HEIGHT AND WIDTH
        
        //DISPLAY THE IMAGE ^
        
        info = nil;
        picker = nil;
        imageToUse = nil;
        originalImage = nil;
        editedImage = nil;
}
    
    [self.picker dismissModalViewControllerAnimated:YES];
    
    self.picker = nil;
    
    placeholderPhoto.visible = false;
    
    AppController *appdelegateObject = [AppController alloc];
    [appdelegateObject ShowWhiteStatusBar];
}

-(void)saveDraft{
    NSMutableArray *picArray = [MGWU objectForKey:@"PictureArray"];
    NSMutableArray *captionArray = [MGWU objectForKey:@"CaptionArray"];
    
    float initialPicArrayCount = picArray.count;
    float initialCaptionArrayCount = captionArray.count;
    
    [picArray addObject: inputedImage];
    [captionArray addObject: inputedCaption];
    
    [MGWU setObject:picArray forKey:@"PictureArray"];
    [MGWU setObject:captionArray forKey:@"CaptionArray"];
    
    NSMutableArray *picArrayTwo = [MGWU objectForKey:@"PictureArray"];
    NSMutableArray *captionArrayTwo = [MGWU objectForKey:@"CaptionArray"];
    
    NSLog(@"You saved %d picture and %d caption", (int)picArrayTwo.count - (int)initialPicArrayCount, (int)captionArrayTwo.count - (int)initialCaptionArrayCount);
    
    [self backtohome];
}

@end