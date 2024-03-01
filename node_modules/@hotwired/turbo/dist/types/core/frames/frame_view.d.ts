import { FrameElement } from "../../elements";
import { Snapshot } from "../snapshot";
import { View, ViewRenderOptions } from "../view";
export type FrameViewRenderOptions = ViewRenderOptions<FrameElement>;
export declare class FrameView extends View<FrameElement> {
    missing(): void;
    get snapshot(): Snapshot<FrameElement>;
}
