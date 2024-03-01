declare global {
    namespace Chai {
        interface AssertStatic {
            equalIgnoringWhitespace(actual: string | null | undefined, expected: string, message?: string): void;
        }
    }
}
declare global {
    interface Window {
        frameScriptEvaluationCount?: number;
    }
}
export {};
