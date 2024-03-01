import { Action } from "../types";
import { FetchResponse } from "../../http/fetch_response";
import { FormSubmission } from "./form_submission";
import { Locatable } from "../url";
import { Visit, VisitDelegate, VisitOptions } from "./visit";
export type NavigatorDelegate = VisitDelegate & {
    allowsVisitingLocationWithAction(location: URL, action?: Action): boolean;
    visitProposedToLocation(location: URL, options: Partial<VisitOptions>): void;
    notifyApplicationAfterVisitingSamePageLocation(oldURL: URL, newURL: URL): void;
};
export declare class Navigator {
    readonly delegate: NavigatorDelegate;
    formSubmission?: FormSubmission;
    currentVisit?: Visit;
    constructor(delegate: NavigatorDelegate);
    proposeVisit(location: URL, options?: Partial<VisitOptions>): void;
    startVisit(locatable: Locatable, restorationIdentifier: string, options?: Partial<VisitOptions>): void;
    submitForm(form: HTMLFormElement, submitter?: HTMLElement): void;
    stop(): void;
    get adapter(): import("../native/adapter").Adapter;
    get view(): import("./page_view").PageView;
    get history(): import("./history").History;
    formSubmissionStarted(formSubmission: FormSubmission): void;
    formSubmissionSucceededWithResponse(formSubmission: FormSubmission, fetchResponse: FetchResponse): Promise<void>;
    formSubmissionFailedWithResponse(formSubmission: FormSubmission, fetchResponse: FetchResponse): Promise<void>;
    formSubmissionErrored(formSubmission: FormSubmission, error: Error): void;
    formSubmissionFinished(formSubmission: FormSubmission): void;
    visitStarted(visit: Visit): void;
    visitCompleted(visit: Visit): void;
    locationWithActionIsSamePage(location: URL, action?: Action): boolean;
    visitScrolledToSamePageLocation(oldURL: URL, newURL: URL): void;
    get location(): URL;
    get restorationIdentifier(): string;
    getActionForFormSubmission({ submitter, formElement }: FormSubmission): Action;
}
