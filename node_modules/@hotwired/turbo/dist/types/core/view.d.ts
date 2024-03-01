import { ReloadReason } from "./native/browser_adapter";
import { Renderer, Render } from "./renderer";
import { Snapshot } from "./snapshot";
import { Position } from "./types";
export interface ViewRenderOptions<E> {
    resume: (value?: any) => void;
    render: Render<E>;
}
export interface ViewDelegate<E extends Element, S extends Snapshot<E>> {
    allowsImmediateRender(snapshot: S, options: ViewRenderOptions<E>): boolean;
    preloadOnLoadLinksForView(element: Element): void;
    viewRenderedSnapshot(snapshot: S, isPreview: boolean): void;
    viewInvalidated(reason: ReloadReason): void;
}
export declare abstract class View<E extends Element, S extends Snapshot<E> = Snapshot<E>, R extends Renderer<E, S> = Renderer<E, S>, D extends ViewDelegate<E, S> = ViewDelegate<E, S>> {
    readonly delegate: D;
    readonly element: E;
    renderer?: R;
    abstract readonly snapshot: S;
    renderPromise?: Promise<void>;
    private resolveRenderPromise;
    private resolveInterceptionPromise;
    constructor(delegate: D, element: E);
    scrollToAnchor(anchor: string | undefined): void;
    scrollToAnchorFromLocation(location: URL): void;
    scrollToElement(element: Element): void;
    focusElement(element: Element): void;
    scrollToPosition({ x, y }: Position): void;
    scrollToTop(): void;
    get scrollRoot(): {
        scrollTo(x: number, y: number): void;
    };
    render(renderer: R): Promise<void>;
    invalidate(reason: ReloadReason): void;
    prepareToRenderSnapshot(renderer: R): Promise<void>;
    markAsPreview(isPreview: boolean): void;
    renderSnapshot(renderer: R): Promise<void>;
    finishRenderingSnapshot(renderer: R): void;
}
