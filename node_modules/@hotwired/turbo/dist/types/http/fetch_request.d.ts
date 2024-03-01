import { FetchResponse } from "./fetch_response";
import { FrameElement } from "../elements/frame_element";
export type TurboBeforeFetchRequestEvent = CustomEvent<{
    fetchOptions: RequestInit;
    url: URL;
    resume: (value?: any) => void;
}>;
export type TurboBeforeFetchResponseEvent = CustomEvent<{
    fetchResponse: FetchResponse;
}>;
export type TurboFetchRequestErrorEvent = CustomEvent<{
    request: FetchRequest;
    error: Error;
}>;
export interface FetchRequestDelegate {
    referrer?: URL;
    prepareRequest(request: FetchRequest): void;
    requestStarted(request: FetchRequest): void;
    requestPreventedHandlingResponse(request: FetchRequest, response: FetchResponse): void;
    requestSucceededWithResponse(request: FetchRequest, response: FetchResponse): void;
    requestFailedWithResponse(request: FetchRequest, response: FetchResponse): void;
    requestErrored(request: FetchRequest, error: Error): void;
    requestFinished(request: FetchRequest): void;
}
export declare enum FetchMethod {
    get = 0,
    post = 1,
    put = 2,
    patch = 3,
    delete = 4
}
export declare function fetchMethodFromString(method: string): FetchMethod | undefined;
export type FetchRequestBody = FormData | URLSearchParams;
export type FetchRequestHeaders = {
    [header: string]: string;
};
export interface FetchRequestOptions {
    headers: FetchRequestHeaders;
    body: FetchRequestBody;
    followRedirects: boolean;
}
export declare class FetchRequest {
    readonly delegate: FetchRequestDelegate;
    readonly method: FetchMethod;
    readonly headers: FetchRequestHeaders;
    readonly url: URL;
    readonly body?: FetchRequestBody;
    readonly target?: FrameElement | HTMLFormElement | null;
    readonly abortController: AbortController;
    private resolveRequestPromise;
    constructor(delegate: FetchRequestDelegate, method: FetchMethod, location: URL, body?: FetchRequestBody, target?: FrameElement | HTMLFormElement | null);
    get location(): URL;
    get params(): URLSearchParams;
    get entries(): [string, FormDataEntryValue][];
    cancel(): void;
    perform(): Promise<FetchResponse | void>;
    receive(response: Response): Promise<FetchResponse>;
    get fetchOptions(): RequestInit;
    get defaultHeaders(): {
        Accept: string;
    };
    get isSafe(): boolean;
    get abortSignal(): AbortSignal;
    acceptResponseType(mimeType: string): void;
    private allowRequestToBeIntercepted;
    private willDelegateErrorHandling;
}
