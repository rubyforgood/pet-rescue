import { FrameElement } from "../../elements/frame_element";
import { Render, Renderer } from "../renderer";
import { Snapshot } from "../snapshot";
export interface FrameRendererDelegate {
    willRenderFrame(currentElement: FrameElement, newElement: FrameElement): void;
}
export declare class FrameRenderer extends Renderer<FrameElement> {
    private readonly delegate;
    static renderElement(currentElement: FrameElement, newElement: FrameElement): void;
    constructor(delegate: FrameRendererDelegate, currentSnapshot: Snapshot<FrameElement>, newSnapshot: Snapshot<FrameElement>, renderElement: Render<FrameElement>, isPreview: boolean, willRender?: boolean);
    get shouldRender(): boolean;
    render(): Promise<void>;
    loadFrameElement(): void;
    scrollFrameIntoView(): boolean;
    activateScriptElements(): void;
    get newScriptElements(): NodeListOf<HTMLScriptElement>;
}
