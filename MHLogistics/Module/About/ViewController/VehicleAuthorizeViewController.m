//
//  VehicleAuthorizeViewController.m
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VehicleAuthorizeViewController.h"
#import "AuthorizeLineView.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"
#import "HZBitPopupView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface VehicleAuthorizeViewController ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak)AuthorizeLineView *alView;
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, strong)NSArray *infoArray;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat willEndContentOffsetX;
@property (nonatomic, assign) CGFloat endContentOffsetX;

//个人信息
@property (nonatomic, strong)NSMutableArray *infoTFArray;
@property (nonatomic, weak) UIButton *nextBtn;

//照片信息
@property (nonatomic, strong)NSMutableArray *imageViewArray;
@property (nonatomic, assign) NSUInteger currentImageViewIdx;
@property (nonatomic, weak) UIButton *nextImageBtn;


@end

@implementation VehicleAuthorizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _infoArray = @[LOCALIZEDSTRING(@"fillVehicleInfo"),LOCALIZEDSTRING(@"uploadPhoto"),LOCALIZEDSTRING(@"waitAuthorize")];
    [self.view addSubview:self.alView];
    [self.view addSubview:self.scrollView];
    [self setCurrentPage:0];
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
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(kScreenWidth*_infoArray.count, height+100)];
    for (NSUInteger i = 0; i < _infoArray.count; i++) {
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, height)];
        sv.tag = i;
        [sv setAlwaysBounceVertical:YES];
        [sv setScrollEnabled:YES];
        [sv setShowsVerticalScrollIndicator:NO];
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
    NSArray *infoArray = @[LOCALIZEDSTRING(@"driveLicensePhoto")];
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

    NSArray *personTitleArray = @[LOCALIZEDSTRING(@"vehicleHKLP"),LOCALIZEDSTRING(@"vehicleMLLP"),LOCALIZEDSTRING(@"vehicleHead"),LOCALIZEDSTRING(@"vehicleCustomNumber"),LOCALIZEDSTRING(@"vehicleICCode"),LOCALIZEDSTRING(@"vehicleAgencyCode"),LOCALIZEDSTRING(@"vehicleTon"),LOCALIZEDSTRING(@"vehicleWidthH"),LOCALIZEDSTRING(@"vehicleCloseRoadPermit")];
    _infoTFArray = [NSMutableArray arrayWithCapacity:personTitleArray.count];
    CGFloat titleWidth = 100;
    CGFloat padding = 40;
    CGFloat height = 30;
    CGRect lastRect = CGRectZero;
    for (NSUInteger i = 0; i < personTitleArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 20 + i*(height + 10), titleWidth, height)];
        if (i == personTitleArray.count - 1) {
            lastRect = CGRectMake(padding, 20 + i*(height + 10), titleWidth, height*2);
            titleLabel.frame = lastRect;
            titleLabel.numberOfLines = 2;
            titleLabel.textAlignment = NSTextAlignmentNatural;
        }
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = personTitleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        [scrollView addSubview:titleLabel];
        
        UITextField *titleTF = [[UITextField alloc] initWithFrame:CGRectMake(padding + titleWidth, titleLabel.frame.origin.y, kScreenWidth-padding*2-titleWidth, height)];
        titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        titleTF.borderStyle = UITextBorderStyleRoundedRect;
        titleTF.tag = i;
        
        [scrollView addSubview:titleTF];
        [_infoTFArray addObject:titleTF];
    }
    
    [scrollView addSubview:self.nextBtn];
    self.nextBtn.frame = CGRectMake(40, lastRect.origin.y + lastRect.size.height + 20, kScreenWidth - 40*2, 40);
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
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"vehicleAuthorizeTitle")];
}

#pragma mark
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    point.y = 0.f;
    scrollView.contentOffset = point;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    _willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _endContentOffsetX = scrollView.contentOffset.x;
    
    if (_endContentOffsetX < _willEndContentOffsetX && _willEndContentOffsetX < _startContentOffsetX) {
        //画面从右往左移动，前一页
        if (_currentPage > 0) {
            _currentPage--;
        }
        
    } else if (_endContentOffsetX > _willEndContentOffsetX && _willEndContentOffsetX > _startContentOffsetX) {
        //画面从左往右移动，后一页
        if (_currentPage < _infoArray.count - 1) {
            _currentPage++;
        }
    }
    [self scrollToPage];
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
    
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint offset = self->_scrollView.contentOffset;
        offset.y = 0;
        offset.x = self->_currentPage*self->_scrollView.frame.size.width;
        self->_scrollView.contentOffset = offset;
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *imageView = _imageViewArray[_currentImageViewIdx];
    imageView.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
