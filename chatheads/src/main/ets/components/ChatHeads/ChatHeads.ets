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

import { ChatHeadModel, Point, Status, vpPoint } from './Types'
import { step } from './Step'

@Entry
@Component
  /**
   * counter is used to produce delay in successive chatheads.
   */
export struct ChatHead {
  chatHeadModel: ChatHeadModel= new ChatHeadModel;
  @State private cPosition: Point = {};
  @State private cStatus: Array<Status> = [];
  private counter: number;

  /**
   * redefines the getPosition function.
   * initializes counter and current position of all chatheds.
   */
  aboutToAppear() {
    this.chatHeadModel.chatheadLength = this.chatHeadModel.images.length
    this.counter = 5 * (this.chatHeadModel.chatheadLength - 2);
    this.chatHeadModel.getPosition = (): Point => {
      return this.cPosition;
    }
    this.cPosition = this.chatHeadModel.position;
    this.chatHeadModel.chatheadLength = this.chatHeadModel.images.length;
    for (var index = 0; index < this.chatHeadModel.chatheadLength - 1; index++) {
      this.cStatus.push({ p: this.chatHeadModel.position, v: { vx: 0, vy: 0 } })
    }
  }

  /**
   *
   * @param fromIndex: the index from update needs to be done
   * untill there, all chatheads are steady. for initial frames chatheads which
   * lower in stack shouldn't move.
   */
  private getUpdatedStatus(fromIndex: number): Array<Status> {
    return this.cStatus.map((element, index) => {
      if (5 * index >= fromIndex) {
        return step(element, this.chatHeadModel.k, this.chatHeadModel.b, this.cPosition);
      }
      else {
        return element;
      }
    });
  }

  /**
   * starts the animation, it is stopped
   * by clearing the setInterval(_,1000/framesPerSecond)
   */
  private startAnimation() {
    this.counter = 5 * (this.chatHeadModel.chatheadLength - 2);
    var interval = setInterval(() => {
      var newS = this.getUpdatedStatus(this.counter);
      this.counter -= this.counter > 0 ? 1 : 0;
      if (this.doStop(newS)) {
        clearInterval(interval)
      }
      this.cStatus = newS;
    }, 1000 / 50)
  }

  /**
   * checks the stopping condition
   * @param s:current status of the chatheads
   * if positions of all chatheads is same as
   * topmost and all velocities are zero, then
   * animation should stop
   */
  private doStop(s: Array<Status>): boolean{
    var stop: boolean = true;
    s.forEach((element, index) => {
      if (!(element.p.x == this.cPosition.x && element.v.vx == 0) || !(element.p.y == this.cPosition.y && element.v.vy == 0)) {
        stop = false;
      }
    })
    return stop;
  }

  /**
   *
   * @param x
   */
  private getVPPosition(pos: Point): vpPoint{
    return { x: pos.x.toString() + 'vp', y: pos.y.toString() + 'vp' };
  }

  /**
   * validate that atleast one image is added.
   */
  private validateImage(): Resource{
    var image = this.chatHeadModel.images[this.chatHeadModel.chatheadLength-1]
    if (image != undefined) {
      return image
    }
    else {
      throw console.error('Atleast one image should be added.')
    }
  }
  /**
   * build function
   *  foreach loop: stacks the chatheads(last in array is at the top)
   */
  build() {
    Stack() {
      ForEach(this.chatHeadModel.images, (item, index) => {
        if (index < this.chatHeadModel.chatheadLength - 1) {
          Stack() {
            Image(item).width('60vp').height('60vp').border({ radius: '30vp', width: '2vp', color: Color.White })
          }
          .position(this.getVPPosition(this.cStatus[index].p))
        }
      })
      Stack() {
        Image(this.validateImage())
          .width('60vp')
          .height('60vp')
          .border({ radius: '30vp', width: '2vp', color: Color.White })
      }
      .position(this.getVPPosition(this.cPosition))
      .onClick((event) => {
        this.chatHeadModel.click(event);
      })
      .onDragStart((event: DragEvent) => {
        this.cPosition.x = event.getX();
        this.cPosition.y = event.getY();
        this.startAnimation();
      })
      .onDragMove((event) => {
        this.cPosition = { x: event.getX(), y: event.getY() };
      })
      .onDragEnter((event) => {
        this.cPosition = { x: event.getX(), y: event.getY() };
      })
      .onDragLeave((event) => {
        this.cPosition = { x: event.getX(), y: event.getY() };
      })
      .onDrop((event) => {
        this.cPosition = { x: event.getX(), y: event.getY() };
      })
    }.opacity(this.chatHeadModel.opacity ? this.chatHeadModel.opacity : 1)
  }
}