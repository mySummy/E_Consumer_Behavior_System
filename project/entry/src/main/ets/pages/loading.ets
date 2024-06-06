import router from '@ohos.router';
@Entry
@Component
struct Page_13 {
  @State value: number = 0
  @State total: number = 100
  @State message: string = '分析-加载'
  @State mode: number = router.getParams()['mode'];
  @State selectedId: number = router.getParams()['selectedId'];
  onLoadComplete() {
    // 跳转到另一个页面
    if (this.mode===1) {
      router.pushUrl({
        url: 'pages/analysis',
        params: { selectedId: this.selectedId }
      }, router.RouterMode.Single,
        err => {
          if (err) {
            console.log('路由失败');
          }
        }
      )
    }
    else if(this.mode===2){
      router.pushUrl({
        url: 'pages/dispatch',
        params: { selectedId: this.selectedId }
      }, router.RouterMode.Single,
        err => {
          if (err) {
            console.log('路由失败');
          }
        }
      )
    }
    else{
      router.pushUrl({
        url: 'pages/userTabs',
        params: { selectedId: this.selectedId }
      }, router.RouterMode.Single,
        err => {
          if (err) {
            console.log('路由失败');
          }
        }
      )
    }
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
    }, 10);
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