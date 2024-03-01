import { Adapter } from "../native/adapter";
import { FetchRequest, FetchRequestDelegate } from "../../http/fetch_request";
import { FetchResponse } from "../../http/fetch_response";
import { History } from "./history";
import { Snapshot } from "../snapshot";
import { PageSnapshot } from "./page_snapshot";
import { Action } from "../types";
import { PageView } from "./page_view";
export interface VisitDelegate {
    readonly adapter: Adapter;
    readonly history: History;
    readonly view: PageView;
    visitStarted(visit: Visit): void;
    visitCompleted(visit: Visit): void;
    locationWithActionIsSamePage(location: URL, action: Action): boolean;
    visitScrolledToSamePageLocation(oldURL: URL, newURL: URL): void;
}
export declare enum TimingMetric {
    visitStart = "visitStart",
    requestStart = "requestStart",
    requestEnd = "requestEnd",
    visitEnd = "visitEnd"
}
export type TimingMetrics = Partial<{
    [metric in TimingMetric]: any;
}>;
export declare enum VisitState {
    initialized = "initialized",
    started = "started",
    canceled = "canceled",
    failed = "failed",
    completed = "completed"
}
export type VisitOptions = {
    action: Action;
    historyChanged: boolean;
    referrer?: URL;
    snapshot?: PageSnapshot;
    snapshotHTML?: string;
    response?: VisitResponse;
    visitCachedSnapshot(snapshot: Snapshot): void;
    willRender: boolean;
    updateHistory: boolean;
    restorationIdentifier?: string;
    shouldCacheSnapshot: boolean;
    frame?: string;
    acceptsStreamResponse: boolean;
};
export type VisitResponse = {
    statusCode: number;
    redirected: boolean;
    responseHTML?: string;
};
export declare enum SystemStatusCode {
    networkFailure = 0,
    timeoutFailure = -1,
    contentTypeMismatch = -2
}
export declare class Visit implements FetchRequestDelegate {
    readonly delegate: VisitDelegate;
    readonly identifier: string;
    readonly restorationIdentifier: string;
    readonly action: Action;
    readonly referrer?: URL;
    readonly timingMetrics: TimingMetrics;
    readonly visitCachedSnapshot: (snapshot: Snapshot) => void;
    readonly willRender: boolean;
    readonly updateHistory: boolean;
    followedRedirect: boolean;
    frame?: number;
    historyChanged: boolean;
    location: URL;
    isSamePage: boolean;
    redirectedToLocation?: URL;
    request?: FetchRequest;
    response?: VisitResponse;
    scrolled: boolean;
    shouldCacheSnapshot: boolean;
    acceptsStreamResponse: boolean;
    snapshotHTML?: string;
    snapshotCached: boolean;
    state: VisitState;
    snapshot?: PageSnapshot;
    constructor(delegate: VisitDelegate, location: URL, restorationIdentifier: string | undefined, options?: Partial<VisitOptions>);
    get adapter(): Adapter;
    get view(): PageView;
    get history(): History;
    get restorationData(): import("./history").RestorationData;
    get silent(): boolean;
    start(): void;
    cancel(): void;
    complete(): void;
    fail(): void;
    changeHistory(): void;
    issueRequest(): void;
    simulateRequest(): void;
    startRequest(): void;
    recordResponse(response?: VisitResponse | undefined): void;
    finishRequest(): void;
    loadResponse(): void;
    getCachedSnapshot(): PageSnapshot | undefined;
    getPreloadedSnapshot(): PageSnapshot | undefined;
    hasCachedSnapshot(): boolean;
    loadCachedSnapshot(): void;
    followRedirect(): void;
    goToSamePageAnchor(): void;
    prepareRequest(request: FetchRequest): void;
    requestStarted(): void;
    requestPreventedHandlingResponse(_request: FetchRequest, _response: FetchResponse): void;
    requestSucceededWithResponse(request: FetchRequest, response: FetchResponse): Promise<void>;
    requestFailedWithResponse(request: FetchRequest, response: FetchResponse): Promise<void>;
    requestErrored(_request: FetchRequest, _error: Error): void;
    requestFinished(): void;
    performScroll(): void;
    scrollToRestoredPosition(): true | undefined;
    scrollToAnchor(): true | undefined;
    recordTimingMetric(metric: TimingMetric): void;
    getTimingMetrics(): TimingMetrics;
    getHistoryMethodForAction(action: Action): (data: any, unused: string, url?: string | URL | null | undefined) => void;
    hasPreloadedResponse(): boolean;
    shouldIssueRequest(): boolean;
    cacheSnapshot(): void;
    render(callback: () => Promise<void>): Promise<void>;
    cancelRender(): void;
}
