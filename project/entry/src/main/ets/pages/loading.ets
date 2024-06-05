import router from '@ohos.router';
@Entry
@Component
struct Page_13 {
  @State value: number = 0
  @State total: number = 100
  @State message: string = '分析-加载'
  params: any = router.getParams()
  int_id:Number = parseInt(this.params.id)
  onLoadComplete() {
    // 跳转到另一个页面
    router.pushUrl({
      url: 'pages/analysis',
      params: { id: this.int_id }
    }, router.RouterMode.Single,
      err => {
        if (err) {
          console.log('路由失败');
        }
      }
    )
  }
  startLoading() {
    let countdown = 0;
    const intervalId = setInterval(() => {
      countdown += 1;
      this.value = countdown;
      if (this.value === this.total) {
        this.onLoadComplete();
        clearInterval(intervalId);
      }
    }, 100);
  }
  build() {
    Row() {
      Column() {
        Progress({
          value: this.value,
          total: this.total,
          type: ProgressType.Ring
        })
        Text('数据加载中')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({top:50})
      }
      .width('100%')
    }
    .height('100%')
    .onAppear(() => {
      this.startLoading();
    })
  }
}