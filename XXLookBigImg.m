//
//  XXLookBigImg.m
//  XXPetManagement
//
//  Created by 段庆烨 on 2020/9/1.
//  Copyright © 2020 魑魅魍魉. All rights reserved.
//

#import "XXLookBigImg.h"

@interface XXLookBigImg()<UIScrollViewDelegate>
@property (strong, nonatomic) UIPageControl *col;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *neiView;
@end

@implementation XXLookBigImg


- (instancetype)initWithArray:(NSArray *)array index:(NSInteger)index{
    if (self = [super init]) {
        [self makeUI];
        [self showWithArray:array index:index];
    }
    return self;
}

- (void)makeUI{
    self.bgColor(@"black");
    self.frame = Rect(0, 0, ScreenWidth, ScreenHeight);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.embedIn(self);
    _scrollView.delegate = self;
    _col = [[UIPageControl alloc] initWithFrame:Rect(0, 0, 0, 0)];
    _col.hidesForSinglePage = YES;
    [_col addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_col];
    _col.makeCons(^{
        make.bottom.equal.view(self).constants(-30);
        make.centerX.equal.view(self);
        make.width.equal.constants(200);
    });
    
    _neiView = View;

    
    
    _neiView.onClick(^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}


- (void)showWithArray:(NSArray *)array index:(NSInteger)index{
    NSInteger count = array.count;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * count, ScreenHeight);
    _neiView.addTo(self.scrollView).makeCons(^{
        make.top.left.bottom.right.equal.view(self.scrollView);
        make.width.equal.constants(array.count*ScreenWidth);
        make.height.equal.constants(ScreenHeight);
    });
    for (int i=0; i<count; i++) {
        UIImageView * imageView = ImageView;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.neiView addSubview:imageView];
        imageView.makeCons(^{
            make.left.equal.view(self.neiView).constants(i*ScreenWidth);
            make.width.equal.constants(ScreenWidth);
            make.top.equal.view(self.neiView).constants(50);
            make.bottom.equal.view(self.neiView).constants(-50);
        });
        if ([array[i] isKindOfClass:[UIImage class]]) {
            imageView.image = array[i];
        }else if ([array[i] isKindOfClass:NSString.class]) {
            [imageView sd_setImageWithURL:Url(array[i]) placeholderImage:placeHoderImageName];
        }
    }
    
    [_scrollView setContentOffset:Point(index*ScreenWidth, 0) animated:YES];
    _col.numberOfPages = array.count;
    _col.currentPage = index;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / ScreenWidth;
    _col.currentPage = page;
}

- (void)changePage:(UIPageControl *)col{
    [_scrollView setContentOffset:Point(col.currentPage * ScreenWidth, 0) animated:YES];
}


- (void)show{
    self.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [KeyWindow addSubview:self];
        self.alpha = 1;
    }];
    
    
}

@end
