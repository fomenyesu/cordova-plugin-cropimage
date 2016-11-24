//
//  CropImage.h
//
//  Created by fomenyesu on 15/11/24
//

#import <Cordova/CDV.h>
#import "VPImageCropperViewController.h"

@interface CropImage : CDVPlugin <VPImageCropperDelegate>

@property (strong) NSString* cropCBID;

- (void)startWork:(CDVInvokedUrlCommand*)command;

@end