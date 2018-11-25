import { ADD_TODO, TOGGLE_TODO, UPDATE_GIFT_TYPE, UPDATE_GIFT_AMOUNT, UPDATE_CUSTOM_GIFT_AMOUNT, UPDATE_CUSTOM_GIFT_STATUS } from "./actionTypes";

let nextTodoId = 0;

export const addTodo = content => ({
  type: ADD_TODO,
  payload: {
    id: ++nextTodoId,
    content
  }
});

export const toggleTodo = id => ({
  type: TOGGLE_TODO,
  payload: { id }
});

export const updateGiftType = frequency => ({
  type: UPDATE_GIFT_TYPE,
  payload: {
    frequency
  }
})

export const updateGiftAmount = amount => ({
  type: UPDATE_GIFT_AMOUNT,
  payload: {
    amount
  }
})

export const updateCustomGiftAmount = amount => ({
  type: UPDATE_CUSTOM_GIFT_AMOUNT,
  payload: {
    amount
  }
})

export const updateCustomGiftStatus = status => ({
  type: UPDATE_CUSTOM_GIFT_STATUS,
  payload: {
    status
  }
})
