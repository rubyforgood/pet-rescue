export declare class StreamMessage {
    static readonly contentType = "text/vnd.turbo-stream.html";
    readonly fragment: DocumentFragment;
    static wrap(message: StreamMessage | string): StreamMessage;
    constructor(fragment: DocumentFragment);
}
