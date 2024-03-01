export interface LinkInterceptorDelegate {
    shouldInterceptLinkClick(element: Element, url: string, originalEvent: MouseEvent): boolean;
    linkClickIntercepted(element: Element, url: string, originalEvent: MouseEvent): void;
}
export declare class LinkInterceptor {
    readonly delegate: LinkInterceptorDelegate;
    readonly element: Element;
    private clickEvent?;
    constructor(delegate: LinkInterceptorDelegate, element: Element);
    start(): void;
    stop(): void;
    clickBubbled: (event: Event) => void;
    linkClicked: EventListener;
    willVisit: EventListener;
    respondsToEventTarget(target: EventTarget | null): boolean | null;
}
