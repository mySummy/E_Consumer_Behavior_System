import router from '@ohos.router'
@Entry
@Component
struct UserTabs {
  @State message: string = '集群分析-分类展示'
  private controller:TabsController = new TabsController()

  build() {
    Row() {
      Column() {
        Row(){
          Text('< 返回')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              router.back({url:"pages/Index"})
            })
            .margin({
              top:'40vp',
              left:'10vp'
            })
        }
        .width('100%')
        Tabs({barPosition:BarPosition.End,controller:this.controller}){
          TabContent(){
            Column()
              .width('100%')
              .height('100%')
          }
          .tabBar('分类1')
          TabContent(){
            Column()
              .width('100%')
              .height('100%')
          }
          .tabBar('分类2')
          TabContent(){
            Column()
              .width('100%')
              .height('100%')
          }
          .tabBar('分类3')
          TabContent(){
            Column()
              .width('100%')
              .height('100%')
          }
          .tabBar('分类4')
        }
        .barMode(BarMode.Scrollable)
        .barWidth('100%')
        .barHeight(60)
        .width('100%')
        .height('100%')
      }
      .width('100%')
    }
    .height('100%')
  }
}