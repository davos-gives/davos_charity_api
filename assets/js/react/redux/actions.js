import {
  UPDATE_GIFT_TYPE,
  UPDATE_GIFT_AMOUNT,
  UPDATE_CUSTOM_GIFT_AMOUNT,
  UPDATE_CUSTOM_GIFT_STATUS,
  UPDATE_PROGRESS_STEP,
  UPDATE_PERSONAL_INFORMATION,
  UPDATE_PAYMENT_INFORMATION,
  UPDATE_REVIEWING_STATUS,
} from "./actionTypes";

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

export const updateProgressStep = step => ({
  type: UPDATE_PROGRESS_STEP,
  payload: {
    step
  }
})

export const updatePersonalInformation = info => ({
  type: UPDATE_PERSONAL_INFORMATION,
  payload: {
    info
  }
})

export const updatePaymentInformation = info => ({
  type: UPDATE_PAYMENT_INFORMATION,
  payload: {
    info
  }
})

export const updateReviewingStatus = () => ({
  type: UPDATE_REVIEWING_STATUS
})
