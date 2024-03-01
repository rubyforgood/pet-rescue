import { BardoDelegate } from "./bardo";
import { Snapshot } from "./snapshot";
import { ReloadReason } from "./native/browser_adapter";
export type Render<E> = (currentElement: E, newElement: E) => void;
export declare abstract class Renderer<E extends Element, S extends Snapshot<E> = Snapshot<E>> implements BardoDelegate {
    readonly currentSnapshot: S;
    readonly newSnapshot: S;
    readonly isPreview: boolean;
    readonly willRender: boolean;
    readonly promise: Promise<void>;
    renderElement: Render<E>;
    private resolvingFunctions?;
    private activeElement;
    constructor(currentSnapshot: S, newSnapshot: S, renderElement: Render<E>, isPreview: boolean, willRender?: boolean);
    get shouldRender(): boolean;
    get reloadReason(): ReloadReason;
    prepareToRender(): void;
    abstract render(): Promise<void>;
    finishRendering(): void;
    preservingPermanentElements(callback: () => void): Promise<void>;
    focusFirstAutofocusableElement(): void;
    enteringBardo(currentPermanentElement: Element): void;
    leavingBardo(currentPermanentElement: Element): void;
    get connectedSnapshot(): S;
    get currentElement(): E;
    get newElement(): E;
    get permanentElementMap(): import("./snapshot").PermanentElementMap;
}
