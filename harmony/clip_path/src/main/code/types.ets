export type TViewBox = [number?, number?, number?, number?]

export interface IViewPort {
  x?: number | string;
  y?: number | string;
  width?: number | string;
  height?: number | string;
}

// export interface IRotateValue {
//   x?: number;
//   y?: number;
//   z?: number;
//   angle?: number | string;
//   centerX?: number | string;
//   centerY?: number | string;
// }

export type TChildrenBuilder = () => void