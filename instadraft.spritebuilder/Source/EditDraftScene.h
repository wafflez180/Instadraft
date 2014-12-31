//
//  EditDraftScene.h
//  instadraft
//
//  Created by Arthur Araujo on 12/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"

@interface EditDraftScene : CCScene <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property UIImagePickerController *picker;

-(void)setUpDraftboxDraft: (NSArray *)draftInfo;

@end
