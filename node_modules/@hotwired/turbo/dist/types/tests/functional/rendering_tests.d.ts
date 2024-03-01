declare global {
    interface Window {
        headScriptEvaluationCount?: number;
        bodyScriptEvaluationCount?: number;
    }
}
export {};
