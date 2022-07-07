### Chatheads
#### Features
    1. User can set initial position of the chatheads.
    2. Chatheads are draggable with animation similar to damped spring system.
    3. Images should be given as parameters to show on the chatheads.
    3. User can stiffness and damping for the animation to adjust the speed and oscillations.
    4. ClickEvent can be handled by giving a callback to onClick() method.
    5. Current position, sstiffness, damping and imaages can be accessed by get<parameter> methods.
    6. Stacked images can be removed one by one(starting from top) using removeHead() method.

#### Import and Install
#### Dependencies
Add the following dependency in `package.json` file of your project folder: `"@ohos/chatheads": "file ../chatheads"`.

    "dependencies": {
        ...
        "@ohos/chatheads": "file ../chatheads"
    }

#### API
    ChatHead({chatheadModel:this.paras})
where `paras` are chathead parameters of type [`ChatheadModel`](README.md#ChatheadModel)

#### ChatheadModel

|Parameter|type|Description|
|-|-|-|
|position|`Point:Object{x?:number,y?:number}`|represent the position of the chathead|
|k|`number`|stiffness of the spring|
|b|`number`|damping of the spring|
|images|`Array<Resource>`|represents the images used on chatheads.|
|click|`Function:(event:ClickEvent)=>{}`|this function is called when Click Event is triggered.|
|opacity|`number|Resource`|sets the opacity of chatheads.|

##### Attributes:
|Method|Argument|description|
|-|-|-|
|setPosition()|`Point:{x?:number,y?:number}`|sets the position parameter and returns the updated class `ChatheadModel`|
|setSpringConstant()|`k:number`|sets the stiffness(spring constant or k) parameter and returns the updated class `ChatheadModel`|
|setDampingConstant()|`b:number`|sets the damping constant parameter and returns the updated class `ChatheadModel`|
|setOpacity()|`opacity:number|Resource`|sets the opacity parameter and returns the updated class `ChatheadModel`|
|addHead()|`image:Resource`|adds a chathead with given image and returns the updated class `ChatheadModel`. Last added appears on the top.|
|addHeads()|`images:Array<Resource>`|add chatheads with given images and returns the updated class `ChatheadModel`|
|getPosition()|-|returns the current position(type Point) of chatheads|
|getSpringConstant()|-|returns the spring constant|
|getDampingConstant()|-|returns the damping constant|
|getHeads()|-|returns the arraay storing images of chatheads|
|removeHead()|-|removes a chathead from the top and returns the updated class `ChatheadModel`|

##### Event
|Event|Description|
|-|-|
|`onClick(callback:(event?:ClickEvent)=>{})`| function argument given is triggered whenever click event is registered on chatheads.|

#### Use Case
    import { ChatHead, ChatheadModel } from "@ohos/chatheads"

    @Entry
    @Component
    struct ChatHeadsSample {
    @State chatheadModel: ChatheadModel = new ChatheadModel();

    aboutToAppear() {
        this.chatheadModel = this.chatheadModel
        .setPosition({ x: 150, y: 150 })
        .addHead($r('app.media.0'))
        .addHead($r('app.media.1'))
        .addHeads([$r('app.media.2'), $r('app.media.3'), $r('app.media.4')])
        .setSprintConstant(200)
        .setDampingConstant(5)
        .onClick((event) => {
            console.log("Damp: " + this.chatheadModel.getDampingConstant());
            console.log("Spring: " + this.chatheadModel.getSpringConstant());
            console.log("Heads: " + JSON.stringify(this.chatheadModel.getHeads()));
            console.log("Position: " + JSON.stringify(this.chatheadModel.getPosition()));
        })
    }

    build() {
        Flex({ direction: FlexDirection.Column }) {
        ChatHead({ chatheadModel: this.chatheadModel })
        }.width('400vp').height('100%').backgroundColor(Color.Yellow)
    }
    }

<img src='./GIF/chathead.gif' width="225" height="400">
#### Comaptibility
Supports OpenHarmony API version 8 and above
#### Code Contribution
If you find any problems during usage, you can submit an [Issue](https://github.com/Applib-OpenHarmony/Chatheads/issues) to us. Of course, we also welcome you to send us [PR](https://github.com/Applib-OpenHarmony/Chatheads/pulls).
#### License
Licensed under the [Apache License, Version 2.0](./LICENSE)
