import { Adapter } from "./native/adapter";
import { ReloadReason } from "./native/browser_adapter";
import { CacheObserver } from "../observers/cache_observer";
import { FormSubmitObserver, FormSubmitObserverDelegate } from "../observers/form_submit_observer";
import { FrameRedirector } from "./frames/frame_redirector";
import { History, HistoryDelegate } from "./drive/history";
import { LinkClickObserver, LinkClickObserverDelegate } from "../observers/link_click_observer";
import { FormLinkClickObserver, FormLinkClickObserverDelegate } from "../observers/form_link_click_observer";
import { Locatable } from "./url";
import { Navigator, NavigatorDelegate } from "./drive/navigator";
import { PageObserver, PageObserverDelegate } from "../observers/page_observer";
import { ScrollObserver } from "../observers/scroll_observer";
import { StreamMessage } from "./streams/stream_message";
import { StreamMessageRenderer } from "./streams/stream_message_renderer";
import { StreamObserver } from "../observers/stream_observer";
import { Action, Position, StreamSource } from "./types";
import { PageView, PageViewDelegate, PageViewRenderOptions } from "./drive/page_view";
import { Visit, VisitOptions } from "./drive/visit";
import { PageSnapshot } from "./drive/page_snapshot";
import { FrameElement } from "../elements/frame_element";
import { FrameViewRenderOptions } from "./frames/frame_view";
import { FetchResponse } from "../http/fetch_response";
import { Preloader, PreloaderDelegate } from "./drive/preloader";
export type FormMode = "on" | "off" | "optin";
export type TimingData = unknown;
export type TurboBeforeCacheEvent = CustomEvent;
export type TurboBeforeRenderEvent = CustomEvent<{
    newBody: HTMLBodyElement;
} & PageViewRenderOptions>;
export type TurboBeforeVisitEvent = CustomEvent<{
    url: string;
}>;
export type TurboClickEvent = CustomEvent<{
    url: string;
    originalEvent: MouseEvent;
}>;
export type TurboFrameLoadEvent = CustomEvent;
export type TurboBeforeFrameRenderEvent = CustomEvent<{
    newFrame: FrameElement;
} & FrameViewRenderOptions>;
export type TurboFrameRenderEvent = CustomEvent<{
    fetchResponse: FetchResponse;
}>;
export type TurboLoadEvent = CustomEvent<{
    url: string;
    timing: TimingData;
}>;
export type TurboRenderEvent = CustomEvent;
export type TurboVisitEvent = CustomEvent<{
    url: string;
    action: Action;
}>;
export declare class Session implements FormSubmitObserverDelegate, HistoryDelegate, FormLinkClickObserverDelegate, LinkClickObserverDelegate, NavigatorDelegate, PageObserverDelegate, PageViewDelegate, PreloaderDelegate {
    readonly navigator: Navigator;
    readonly history: History;
    readonly preloader: Preloader;
    readonly view: PageView;
    adapter: Adapter;
    readonly pageObserver: PageObserver;
    readonly cacheObserver: CacheObserver;
    readonly linkClickObserver: LinkClickObserver;
    readonly formSubmitObserver: FormSubmitObserver;
    readonly scrollObserver: ScrollObserver;
    readonly streamObserver: StreamObserver;
    readonly formLinkClickObserver: FormLinkClickObserver;
    readonly frameRedirector: FrameRedirector;
    readonly streamMessageRenderer: StreamMessageRenderer;
    drive: boolean;
    enabled: boolean;
    progressBarDelay: number;
    started: boolean;
    formMode: FormMode;
    start(): void;
    disable(): void;
    stop(): void;
    registerAdapter(adapter: Adapter): void;
    visit(location: Locatable, options?: Partial<VisitOptions>): void;
    connectStreamSource(source: StreamSource): void;
    disconnectStreamSource(source: StreamSource): void;
    renderStreamMessage(message: StreamMessage | string): void;
    clearCache(): void;
    setProgressBarDelay(delay: number): void;
    setFormMode(mode: FormMode): void;
    get location(): URL;
    get restorationIdentifier(): string;
    historyPoppedToLocationWithRestorationIdentifier(location: URL, restorationIdentifier: string): void;
    scrollPositionChanged(position: Position): void;
    willSubmitFormLinkToLocation(link: Element, location: URL): boolean;
    submittedFormLinkToLocation(): void;
    willFollowLinkToLocation(link: Element, location: URL, event: MouseEvent): boolean;
    followedLinkToLocation(link: Element, location: URL): void;
    allowsVisitingLocationWithAction(location: URL, action?: Action): boolean;
    visitProposedToLocation(location: URL, options: Partial<VisitOptions>): void;
    visitStarted(visit: Visit): void;
    visitCompleted(visit: Visit): void;
    locationWithActionIsSamePage(location: URL, action?: Action): boolean;
    visitScrolledToSamePageLocation(oldURL: URL, newURL: URL): void;
    willSubmitForm(form: HTMLFormElement, submitter?: HTMLElement): boolean;
    formSubmitted(form: HTMLFormElement, submitter?: HTMLElement): void;
    pageBecameInteractive(): void;
    pageLoaded(): void;
    pageWillUnload(): void;
    receivedMessageFromStream(message: StreamMessage): void;
    viewWillCacheSnapshot(): void;
    allowsImmediateRender({ element }: PageSnapshot, options: PageViewRenderOptions): boolean;
    viewRenderedSnapshot(_snapshot: PageSnapshot, _isPreview: boolean): void;
    preloadOnLoadLinksForView(element: Element): void;
    viewInvalidated(reason: ReloadReason): void;
    frameLoaded(frame: FrameElement): void;
    frameRendered(fetchResponse: FetchResponse, frame: FrameElement): void;
    applicationAllowsFollowingLinkToLocation(link: Element, location: URL, ev: MouseEvent): boolean;
    applicationAllowsVisitingLocation(location: URL): boolean;
    notifyApplicationAfterClickingLinkToLocation(link: Element, location: URL, event: MouseEvent): CustomEvent<{
        url: string;
        originalEvent: MouseEvent;
    }>;
    notifyApplicationBeforeVisitingLocation(location: URL): CustomEvent<{
        url: string;
    }>;
    notifyApplicationAfterVisitingLocation(location: URL, action: Action): CustomEvent<{
        url: string;
        action: Action;
    }>;
    notifyApplicationBeforeCachingSnapshot(): CustomEvent<any>;
    notifyApplicationBeforeRender(newBody: HTMLBodyElement, options: PageViewRenderOptions): CustomEvent<{
        newBody: HTMLBodyElement;
    } & PageViewRenderOptions>;
    notifyApplicationAfterRender(): CustomEvent<any>;
    notifyApplicationAfterPageLoad(timing?: TimingData): CustomEvent<{
        url: string;
        timing: unknown;
    }>;
    notifyApplicationAfterVisitingSamePageLocation(oldURL: URL, newURL: URL): void;
    notifyApplicationAfterFrameLoad(frame: FrameElement): CustomEvent<any>;
    notifyApplicationAfterFrameRender(fetchResponse: FetchResponse, frame: FrameElement): CustomEvent<{
        fetchResponse: FetchResponse;
    }>;
    submissionIsNavigatable(form: HTMLFormElement, submitter?: HTMLElement): boolean;
    elementIsNavigatable(element: Element): boolean;
    getActionForLink(link: Element): Action;
    get snapshot(): PageSnapshot;
}
