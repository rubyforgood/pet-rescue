import { FormSubmitObserver, FormSubmitObserverDelegate } from "../../observers/form_submit_observer";
import { LinkInterceptor, LinkInterceptorDelegate } from "./link_interceptor";
import { Session } from "../session";
export declare class FrameRedirector implements LinkInterceptorDelegate, FormSubmitObserverDelegate {
    readonly session: Session;
    readonly element: Element;
    readonly linkInterceptor: LinkInterceptor;
    readonly formSubmitObserver: FormSubmitObserver;
    constructor(session: Session, element: Element);
    start(): void;
    stop(): void;
    shouldInterceptLinkClick(element: Element, _location: string, _event: MouseEvent): boolean;
    linkClickIntercepted(element: Element, url: string, event: MouseEvent): void;
    willSubmitForm(element: HTMLFormElement, submitter?: HTMLElement): boolean;
    formSubmitted(element: HTMLFormElement, submitter?: HTMLElement): void;
    private shouldSubmit;
    private shouldRedirect;
    private findFrameElement;
}
