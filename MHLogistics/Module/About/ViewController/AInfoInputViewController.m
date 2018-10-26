//
//  AInfoInputViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AInfoInputViewController.h"
#import "AuthorizeLineView.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"
#import "HZBitPopupView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface AInfoInputViewController ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak)AuthorizeLineView *alView;
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, strong)NSArray *infoArray;
@property (nonatomic, assign) NSUInteger currentPage;

//个人信息
@property (nonatomic, strong)NSMutableArray *infoTFArray;
@property (nonatomic, weak) UIButton *nextBtn;

//照片信息
@property (nonatomic, strong)NSMutableArray *imageViewArray;
@property (nonatomic, assign) NSUInteger currentImageViewIdx;
@property (nonatomic, weak) UIButton *nextImageBtn;
@end

@implementation AInfoInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _infoArray = @[LOCALIZEDSTRING(@"fillPersonalInfo"),LOCALIZEDSTRING(@"uploadPhoto"),LOCALIZEDSTRING(@"waitAuthorize")];
    [self.view addSubview:self.alView];
    [self.view addSubview:self.scrollView];
    [self setCurrentPage:1];
}

- (UIView *)scrollView {
    if (_scrollView) {
        return _scrollView;
    }
    
    CGFloat startY = _alView.frame.origin.y + _alView.frame.size.height;
    CGFloat height = self.view.frame.size.height - startY;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, startY, kScreenWidth, height)];
    [scrollView setDelegate:self];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setAlwaysBounceHorizontal:YES];
    [scrollView setPagingEnabled:YES];
    [scrollView setScrollEnabled:NO];
    [scrollView setContentSize:CGSizeMake(kScreenWidth*_infoArray.count, height)];
    for (NSUInteger i = 0; i < _infoArray.count; i++) {
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, height)];
        sv.tag = i;
        [sv setContentSize:CGSizeMake(kScreenWidth, height)];
        if (i == 0) {
            [self addPersonInfo:sv];
        }
        else if(i == 1){
            [sv setContentSize:CGSizeMake(kScreenWidth, height*2)];
            [sv setShowsVerticalScrollIndicator:NO];
            [sv setAlwaysBounceVertical:YES];
            [self takePhoto:sv];
        }

        [scrollView addSubview:sv];
    }
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    return scrollView;
}

- (void)takePhoto:(UIScrollView *)scrollView {
    NSArray *infoArray = @[LOCALIZEDSTRING(@"personAndIdentifyPhoto"),LOCALIZEDSTRING(@"identifyFrontPhoto"),LOCALIZEDSTRING(@"identifyBackPhoto"),LOCALIZEDSTRING(@"customsRecordNumber"),LOCALIZEDSTRING(@"driveLicensePhoto"),LOCALIZEDSTRING(@"driveLicensesPhoto")];
    CGFloat height = 130;
    CGFloat padding = 50;
    _imageViewArray = [NSMutableArray arrayWithCapacity:infoArray.count];
    _currentImageViewIdx = -1;
    CGFloat lastBottom = 0;
    for (NSUInteger i = 0; i < infoArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding, 20*(i+1) + i*height, kScreenWidth-padding*2, height)];
        imageView.tag = i;
        imageView.layer.borderWidth = 1.0;
        imageView.layer.borderColor = GrayColor.CGColor;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhotos:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapGesture];
        [scrollView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, height)];
        label.text = infoArray[i];
        label.font = [UIFont systemFontOfSize:13.0];
        label.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:label];
        
        [_imageViewArray addObject:imageView];
        
        if (i == infoArray.count-1) {
            lastBottom = imageView.frame.origin.y+imageView.frame.size.height+20;
        }
    }
    
    [scrollView addSubview:self.nextImageBtn];
    self.nextImageBtn.frame = CGRectMake(30, lastBottom, kScreenWidth-30*2, 40);
}

- (UIButton *)nextImageBtn {
    if (_nextImageBtn) {
        return _nextImageBtn;
    }
    UIButton *nextImageBtn = [[UIButton alloc] init];
    [nextImageBtn addTarget:self action:@selector(nextImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextImageBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [nextImageBtn setTitle:LOCALIZEDSTRING(@"next") forState:UIControlStateNormal];
    [nextImageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextImageBtn.layer.cornerRadius = 20;
    nextImageBtn.layer.masksToBounds = YES;
    _nextImageBtn = nextImageBtn;
    return nextImageBtn;
}

- (void)nextImageAction:(UIButton *)btn {
    
}

- (void)takePhotos:(UITapGestureRecognizer *)recongnizer {
    UIImageView *imageView = (UIImageView *)[recongnizer view];
    NSInteger tag = imageView.tag;
    _currentImageViewIdx = tag;
    NSArray *phoneArray = @[LOCALIZEDSTRING(@"localPhoto"), LOCALIZEDSTRING(@"takePhoto")];
    HZBitPopupView *hzBitPopupView = [[HZBitPopupView alloc] initHZBitPopupView:phoneArray];
    
    MHWeakSelf();
    hzBitPopupView.block = ^(NSInteger index) {
        [weakSelf takePhotoAction:index];
    };
    [hzBitPopupView show];
}
        

- (void)takePhotoAction:(NSInteger)tag {
    if (tag == 0) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:LOCALIZEDSTRING(@"noAlbumnRight") message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            [alertView show];
            return;
        }
    }else if (tag == 1) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //无权限
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:LOCALIZEDSTRING(@"noCameraRight") message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            [alertView show];
            return;
        }
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate      = self;
    imagePicker.allowsEditing = NO;
    UIImagePickerControllerSourceType sourceType = tag == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
    imagePicker.sourceType = sourceType;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)addPersonInfo:(UIScrollView *)scrollView {
    if (!scrollView) {
        return;
    }
    
    NSArray *personTitleArray = @[LOCALIZEDSTRING(@"name"),LOCALIZEDSTRING(@"phone"),LOCALIZEDSTRING(@"phoneHK"),LOCALIZEDSTRING(@"customsRecordNumber"),LOCALIZEDSTRING(@"identifyNumber")];
    _infoTFArray = [NSMutableArray arrayWithCapacity:personTitleArray.count];
    CGFloat titleWidth = 100;
    CGFloat padding = 40;
    CGFloat height = 30;
    for (NSUInteger i = 0; i < personTitleArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 20 + i*(height + 20), titleWidth, height)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = personTitleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        [scrollView addSubview:titleLabel];
        
        UITextField *titleTF = [[UITextField alloc] initWithFrame:CGRectMake(padding + titleWidth, titleLabel.frame.origin.y, kScreenWidth-padding*2-titleWidth, height)];
        titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        titleTF.borderStyle = UITextBorderStyleRoundedRect;
        titleTF.tag = i;
        if (i == 0) {
            titleTF.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        else if (i == 1 || i == 2)
        {
            titleTF.keyboardType = UIKeyboardTypePhonePad;
        }
        else
        {
            titleTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
            
        [scrollView addSubview:titleTF];
        [_infoTFArray addObject:titleTF];
    }
    
    [scrollView addSubview:self.nextBtn];
    self.nextBtn.frame = CGRectMake(40, scrollView.frame.size.height - 100, kScreenWidth - 40*2, 40);
}


- (UIButton *)nextBtn {
    if (_nextBtn) {
        return _nextBtn;
    }
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [nextBtn setTitle:LOCALIZEDSTRING(@"next") forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.layer.masksToBounds = YES;
    _nextBtn = nextBtn;
    return nextBtn;
}

- (void)nextAction:(UIButton *)btn {
    
}

- (AuthorizeLineView *)alView {
    if (_alView) {
        return _alView;
    }
    
    CGRect rect = CGRectMake(0, 100, kScreenWidth, 60);
    AuthorizeLineView *alView = [[AuthorizeLineView alloc] initWithFrame:rect array:_infoArray];
    _alView = alView;
    return alView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"authenticationInformationInput")];
}


- (void)setCurrentPage:(NSUInteger)currentPage {
    _currentPage = currentPage;
    [self scrollToPage];
}

- (void)moveToNextIdx {
    _currentPage++;
    [self scrollToPage];
}

- (void)scrollToPage {
    [_alView setCurrentIdx:_currentPage];
    
    CGPoint offset = self->_scrollView.contentOffset;
    offset.y = 0;
    offset.x = self->_currentPage*self->_scrollView.frame.size.width;
    self->_scrollView.contentOffset = offset;

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *imageView = _imageViewArray[_currentImageViewIdx];
    imageView.image = image;
}


@end
