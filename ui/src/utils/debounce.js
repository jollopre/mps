export const debounce = (func, wait) => {
  let timeout = null;
  const r = () => {
    const later = () => {
      timeout = null;
      func.apply(this, []);
    }
    clearTimeout(timeout);
    timeout = setTimeout(later, wait || 200);
  }
  r.cancel = () => {
    if (timeout !== null) {
      clearTimeout(timeout);
      timeout = null;
      return true;
    }
    return false;
  }
  return r;
}
