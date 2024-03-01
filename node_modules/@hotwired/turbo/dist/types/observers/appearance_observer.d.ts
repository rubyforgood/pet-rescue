export interface AppearanceObserverDelegate<T extends Element> {
    elementAppearedInViewport(element: T): void;
}
export declare class AppearanceObserver<T extends Element> {
    readonly delegate: AppearanceObserverDelegate<T>;
    readonly element: T;
    readonly intersectionObserver: IntersectionObserver;
    started: boolean;
    constructor(delegate: AppearanceObserverDelegate<T>, element: T);
    start(): void;
    stop(): void;
    intersect: IntersectionObserverCallback;
}
