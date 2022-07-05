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

/**
 * type Point represents the position
 * of a chathead
 */
export type Point = {
  x?: number;
  y?: number;
}

/**
 * to store the nummerical positions in vp string format.
 */
export type vpPoint = {
  x?: Length;
  y?: Length;
}
/**
 * type Velocity represents velocity
 * of a chathead
 */
export type Velocity = {
  vx: number;
  vy: number;
}

/**
 * Status represents the current status
 * (position and velocity) of chathead
 */
export type Status = {
  p: Point
  v: Velocity;
}

/**
 * model class to intialize and maintain
 * the chathead
 */
export class ChatHeadModel {
  position?: Point = { x: 0, y: 150 };
  k: number= 100;
  b: number= 5;
  chatheadLength?: number;
  images?: Array<Resource> = [];
  click?: Function = (event: ClickEvent) => {
  };
  opacity?: number | Resource;
  /**
   * initialize initial position of chatheads.
   * @param pos: initial position of chatheads(should be a point)
   */
  setPosition?(pos: Point): ChatHeadModel{
    this.position = pos;
    return this;
  }

  /**
   * sets the spring constant
   * @param k: defines the stiffness of spring
   * responsible for to-and-fro motion
   */
  setSprintConstant?(k: number): ChatHeadModel{
    this.k = k;
    return this;
  }

  /**
   * sets the damping constant
   * @param b: defines the damping in the system,
   * larger the value quickly the speed decreases.
   */
  setDampingConstant?(b: number): ChatHeadModel{
    this.b = b;
    return this;
  }

  /**
   * sets the opacity of chatheads
   * @param opacity: if a number then should be from 0 to 1
   */
  setOpacity(opacity: number | Resource): ChatHeadModel{
    this.opacity = opacity;
    return this;
  }
  /**
   * add heads.
   * @param image: image of the chathead.
   * last image in the array is the one appearing at
   * top in stacked chatheads.
   */
  addHead?(image: Resource): ChatHeadModel{
    this.images.push(image);
    this.chatheadLength += 1
    return this;
  }

  /**
   * instead of single image, it adds array of images for chatheads.
   * @param images: array of images.
   */
  addHeads?(images: Array<Resource>): ChatHeadModel{
    this.images = this.images.concat(images);
    this.chatheadLength = this.images.length;
    return this;
  }

  /**
   * returns the position of topmost chathead,
   * the one which moves with drag position.
   */
  getPosition?(): Point{
    return this.position;
  }

  /**
   * returns spring constant;
   */
  getSpringConstant?(): number{
    return this.k;
  }

  /**
   * returns damping constant
   */
  getDampingConstant?(): number{
    return this.b;
  }

  /**
   * returns the array of images
   */
  getHeads?(): Array<Resource>{
    return this.images;
  }

  /**
   * removes the topmost head of chathead.
   */
  removeHead?(): ChatHeadModel{
    this.images.pop();
    return this;
  }

  /**
   * click function is called when Chathead is clicked.
   * @param callback: a function with optional parameter event:ClickEvent
   */
  onClick(callback: Function): ChatHeadModel{
    this.click = callback;
    return this;
  }
}