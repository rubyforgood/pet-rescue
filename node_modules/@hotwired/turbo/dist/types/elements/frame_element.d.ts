import { FetchResponse } from "../http/fetch_response";
import { Snapshot } from "../core/snapshot";
import { LinkInterceptorDelegate } from "../core/frames/link_interceptor";
import { FormSubmitObserverDelegate } from "../observers/form_submit_observer";
export declare enum FrameLoadingStyle {
    eager = "eager",
    lazy = "lazy"
}
export type FrameElementObservedAttribute = keyof FrameElement & ("disabled" | "complete" | "loading" | "src");
export interface FrameElementDelegate extends LinkInterceptorDelegate, FormSubmitObserverDelegate {
    connect(): void;
    disconnect(): void;
    completeChanged(): void;
    loadingStyleChanged(): void;
    sourceURLChanged(): void;
    sourceURLReloaded(): Promise<void>;
    disabledChanged(): void;
    loadResponse(response: FetchResponse): void;
    proposeVisitIfNavigatedWithAction(frame: FrameElement, element: Element, submitter?: HTMLElement): void;
    fetchResponseLoaded: (fetchResponse: FetchResponse) => void;
    visitCachedSnapshot: (snapshot: Snapshot) => void;
    isLoading: boolean;
}
export declare class FrameElement extends HTMLElement {
    static delegateConstructor: new (element: FrameElement) => FrameElementDelegate;
    loaded: Promise<void>;
    readonly delegate: FrameElementDelegate;
    static get observedAttributes(): FrameElementObservedAttribute[];
    constructor();
    connectedCallback(): void;
    disconnectedCallback(): void;
    reload(): Promise<void>;
    attributeChangedCallback(name: string): void;
    get src(): string | null;
    set src(value: string | null);
    get loading(): FrameLoadingStyle;
    set loading(value: FrameLoadingStyle);
    get disabled(): boolean;
    set disabled(value: boolean);
    get autoscroll(): boolean;
    set autoscroll(value: boolean);
    get complete(): boolean;
    get isActive(): boolean;
    get isPreview(): boolean;
}
