export interface LinkClickObserverDelegate {
    willFollowLinkToLocation(link: Element, location: URL, event: MouseEvent): boolean;
    followedLinkToLocation(link: Element, location: URL): void;
}
export declare class LinkClickObserver {
    readonly delegate: LinkClickObserverDelegate;
    readonly eventTarget: EventTarget;
    started: boolean;
    constructor(delegate: LinkClickObserverDelegate, eventTarget: EventTarget);
    start(): void;
    stop(): void;
    clickCaptured: () => void;
    clickBubbled: (event: Event) => void;
    clickEventIsSignificant(event: MouseEvent): boolean;
    findLinkFromClickTarget(target: EventTarget | null): HTMLAnchorElement | undefined;
    getLocationForLink(link: Element): URL;
}
