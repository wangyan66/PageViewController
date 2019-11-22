//
//  ViewController.m
//  Test
//
//  Created by 王焱 on 2019/11/19.
//  Copyright © 2019 王焱. All rights reserved.
//

#import "ViewController.h"
#import "WyMessageTableViewViewController.h"
#import "WyMessageViewController.h"
#import <Foundation/Foundation.h>
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
//显示一下选择的图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIImagePickerController* pickController;

@end

@implementation ViewController
- (IBAction)goToMsgVC:(id)sender {
    
    //WyMessageTableViewViewController *vc = [[WyMessageTableViewViewController alloc]init];
    WyMessageViewController *vc = [[WyMessageViewController alloc]init];
    vc.modalPresentationStyle = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSString *)change:(UIImage*)image{
    //UIImage图片转Base64字符串：

    UIImage *originImage = image;
    
    NSData *imgData = UIImageJPEGRepresentation(originImage, 1.0f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    //Base64字符串转UIImage图片：

    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    self.imageView.image = decodedImage;
    return [self urlEncodeStr:encodedImageStr];
    
}
/**
 *  URLEncode
 */
- (NSString *)urlEncodeStr:(NSString *)input{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedStringWithEncodedStr:(NSString *)encodedString{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)encodedString,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (IBAction)clicked:(id)sender {
    [self selectImageSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:@"test.png"];
    // Do any additional setup after loading the view.
}
- (void)sendRequest:(UIImage *)image{
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"User-Agent": @"PostmanRuntime/7.19.0",
                               @"Accept": @"*/*",
                               @"Cache-Control": @"no-cache",
                               @"Postman-Token": @"db2f62ef-134e-42e2-a233-c2fb3f8fdbc3,d6fdc4ec-e9f0-404e-adb1-9a9257d90396",
                               @"Host": @"aip.baidubce.com",
                               @"Accept-Encoding": @"gzip, deflate",
                               @"Content-Length": @"1242594",
                               @"Connection": @"keep-alive",
                               @"cache-control": @"no-cache" };
    NSString *str1 = @"image=";
    NSString *str  = [str1 stringByAppendingFormat:@"%@", [self change:image]];
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://aip.baidubce.com/rest/2.0/ocr/v1/license_plate?access_token=24.75b832dfb59d0baef0999680113c2973.2592000.1576852660.282335-17818844"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        NSLog(@"%@",str);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.textView.text = str;
                                                        });
                                                    }
                                                }];
    [dataTask resume];

}
- (void)selectImageSource {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        self.pickController = imagePicker;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;//编辑模式  但是编辑框是正方形的
        // 使用前置还是后置摄像头
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;

          #// 设置可用的媒体类型、默认只包含kUTTypeImage
            //imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];

            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //设置照片来源

                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            [actionSheet addAction:cameraAction];
            [actionSheet addAction:photoAction];
            [actionSheet addAction:cancelAction];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
    }else{
        return;
    }
    
}

#pragma mark - =======UIImagePickerControllerDelegate=========

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
//查看是视频还是照片  public.image 或 public.movie
NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//照片
        UIImage* editedImage =(UIImage *)[info objectForKey:
                    UIImagePickerControllerEditedImage]; //取出编辑过的照片
        UIImage* originalImage =(UIImage *)[info objectForKey:
                    UIImagePickerControllerOriginalImage];//取出原生照片
        UIImage* imageToSave = nil;
        if(editedImage){
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
    //将新图像（原始图像或已编辑）保存到相机胶卷
        self.imageView.image= imageToSave;
        [self calulateImageFileSize:imageToSave];
        [self.imageView sizeToFit];
//        [self sendRequest:imageToSave];
        [self sendOCRRequest:imageToSave];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)calulateImageFileSize:(UIImage *)image {
    
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 0.5);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}

- (void)sendOCRRequest:(UIImage *)image{
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache",
                               @"Postman-Token": @"62eed723-01d9-4ad8-849a-73d99417edc3" };

    NSString *str1 = @"image=";
    NSString *str  = [str1 stringByAppendingFormat:@"%@", [self change:image]];
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //[postData appendData:[@"&detect_direction=true" dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=24.75b832dfb59d0baef0999680113c2973.2592000.1576852660.282335-17818844"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        NSLog(@"%@",str);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.textView.text = str;
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}
@end


