//
//  CropImage.m
//
//  Created by fomenyesu on 15/11/24
//

#import "CropImage.h"
#import "VPImageCropperViewController.h"

@implementation CropImage

@synthesize cropCBID;

- (void)startWork:(CDVInvokedUrlCommand*)command{
    CDVPluginResult* pluginResult = nil;
    cropCBID = command.callbackId;
    NSLog(@"startWork %@", [command.arguments objectAtIndex:0]);
    
    @try {
        NSString *filePath = [command.arguments objectAtIndex:0];
        
        //            NSMutableDictionary *args = [command.arguments objectAtIndex:0];
        //            NSString *filePath = [args objectForKey:@"filePath"];
        
        // 通过图片路径创建CIImage
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
        UIImage *inputImage = [UIImage imageWithData:imageData];
        
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:inputImage cropFrame:CGRectMake(0, 100.0f, self.webView.frame.size.width, self.webView.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self.viewController presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_JSON_EXCEPTION messageAsString:[exception reason]];
    }
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    CDVPluginResult* pluginResult = nil;
    UIImage* newImage = editedImage;
    
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    int r = arc4random() % 5000;
    NSString *random = [NSString stringWithFormat:@"%d", r];
    NSString *tPathA = [documentsPath stringByAppendingPathComponent:@"crop"];
    NSString *tPathB = [tPathA stringByAppendingString:random];
    NSString *filePathB = [tPathB stringByAppendingString:@".jpg"];
    
    [imageData writeToFile:filePathB atomically:YES];
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:filePathB];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:cropCBID];
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

// CAMERA ROLL SAVER
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        NSLog(@"ERROR: %@",error);
    }
    else  // No errors
    {
        // Show message image successfully saved
        NSLog(@"IMAGE SAVED!");
    }
}

@end