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

import { Point, Velocity, Status } from './Types'

const precision: number = 0.1;
const secondsPerFrame: number = 1 / 50;

/**
 * returns the updated status of chathead in one frame.
 * @param s: current status
 * @param k: spring constant
 * @param b: damping constnt
 * @param destPos: final position of chatheads.
 * works on the principles of damped spring with final
 * position as the natural position(neither compressed
 * nor stretched) and initial position as compressed/stretched
 * spring.
 */
export function step(s: Status, k: number, b: number, destPos: Point): Status {

  let fSpringX = -k * (s.p.x - destPos.x);
  let fSpringY = -k * (s.p.y - destPos.y);

  let fDamperX = -b * s.v.vx;
  let fDamperY = -b * s.v.vy;

  let aX = (fSpringX / 10 + fDamperX);
  let aY = (fSpringY / 10 + fDamperY);

  let newV: Velocity = { vx: s.v.vx + aX * secondsPerFrame, vy: s.v.vy + aY * secondsPerFrame };
  let newP: Point = { x: s.p.x + newV.vx * secondsPerFrame, y: s.p.y + newV.vy * secondsPerFrame };

  if (Math.abs(newP.x - destPos.x) <= precision && Math.abs(newV.vx) <= precision) {
    newP.x = destPos.x;
    newV.vx = 0;
  }

  if (Math.abs(newP.y - destPos.y) <= precision && Math.abs(newV.vy) <= precision) {
    newP.y = destPos.y;
    newV.vy = 0;
  }

  return { p: newP, v: newV };
}