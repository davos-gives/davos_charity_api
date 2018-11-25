export const getProgress = store =>
  store.progress

export const getGiftInfo = store =>
  store.giftInfo

/**
 * example of a slightly more complex selector
 * select from store combining information from multiple reducers
 */
export const getTodos = store =>
  getTodoList(store).map(id => getTodoById(store, id));
