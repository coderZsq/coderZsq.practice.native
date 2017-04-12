export function NativePush(path) {
  window.webkit.messageHandlers.push.postMessage(path);
}

export function NativeParams(params) {
  window.webkit.messageHandlers.params.postMessage(params);
}
