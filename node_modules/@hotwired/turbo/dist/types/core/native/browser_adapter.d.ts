import { Adapter } from "./adapter";
import { ProgressBar } from "../drive/progress_bar";
import { Visit, VisitOptions } from "../drive/visit";
import { FormSubmission } from "../drive/form_submission";
import { Session } from "../session";
export type ReloadReason = StructuredReason | undefined;
interface StructuredReason {
    reason: string;
    context?: {
        [key: string]: any;
    };
}
export declare class BrowserAdapter implements Adapter {
    readonly session: Session;
    readonly progressBar: ProgressBar;
    visitProgressBarTimeout?: number;
    formProgressBarTimeout?: number;
    location?: URL;
    constructor(session: Session);
    visitProposedToLocation(location: URL, options?: Partial<VisitOptions>): void;
    visitStarted(visit: Visit): void;
    visitRequestStarted(visit: Visit): void;
    visitRequestCompleted(visit: Visit): void;
    visitRequestFailedWithStatusCode(visit: Visit, statusCode: number): void;
    visitRequestFinished(_visit: Visit): void;
    visitCompleted(_visit: Visit): void;
    pageInvalidated(reason: ReloadReason): void;
    visitFailed(_visit: Visit): void;
    visitRendered(_visit: Visit): void;
    formSubmissionStarted(_formSubmission: FormSubmission): void;
    formSubmissionFinished(_formSubmission: FormSubmission): void;
    showVisitProgressBarAfterDelay(): void;
    hideVisitProgressBar(): void;
    showFormProgressBarAfterDelay(): void;
    hideFormProgressBar(): void;
    showProgressBar: () => void;
    reload(reason: ReloadReason): void;
    get navigator(): import("../drive/navigator").Navigator;
}
export {};
