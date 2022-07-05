/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { ChatHead, ChatheadModel } from "@ohos/chatheads"

@Entry
@Component
struct ChatHeadsSample {
  @State chatheadModel0: ChatheadModel = new ChatheadModel();
  @State chatheadModel1: ChatheadModel = new ChatheadModel();

  aboutToAppear() {
    this.chatheadModel0 = this.chatheadModel0
//      .setPosition({ x: 150, y: 150 })
      .addHead($r('app.media.0'))
      .addHead($r('app.media.1'))
      .addHeads([$r('app.media.2'), $r('app.media.3'), $r('app.media.4')])
      .setSprintConstant(200)
      .setDampingConstant(5)
      .onClick((event) => {
        this.chatheadModel0 = this.chatheadModel0.removeHead();
        console.log("Damp: " + this.chatheadModel0.getDampingConstant());
        console.log("Spring: " + this.chatheadModel0.getSpringConstant());
        console.log("Heads: " + JSON.stringify(this.chatheadModel0.getHeads()));
        console.log("Position: " + JSON.stringify(this.chatheadModel0.getPosition()));
      })

    this.chatheadModel1.position = { x: 150, y: 300 };
    this.chatheadModel1.k = 300;
    this.chatheadModel1.b = 5;
    this.chatheadModel1.images = [$r("app.media.4"), $r("app.media.3"), $r("app.media.2"), $r("app.media.1"), $r("app.media.0")];
    this.chatheadModel1.opacity = 0.1;
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      ChatHead({ chatheadModel: this.chatheadModel0 })
      ChatHead({ chatheadModel: this.chatheadModel1 })
    }.width('400vp').height('700vp').backgroundColor(Color.Yellow)
  }
}