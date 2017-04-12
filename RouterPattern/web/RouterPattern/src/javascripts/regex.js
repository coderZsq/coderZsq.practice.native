export function URLQuery(key) {

  let reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
  let r = window.location.search.substr(1).match(reg);
  if (r != null) {
    return unescape(r[2]);
  }
  return null;
}
