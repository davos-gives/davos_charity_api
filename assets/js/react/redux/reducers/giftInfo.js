import { UPDATE_GIFT_TYPE, UPDATE_GIFT_AMOUNT, UPDATE_CUSTOM_GIFT_AMOUNT, UPDATE_CUSTOM_GIFT_STATUS, UPDATE_SOURCE } from "../actionTypes";

const initialState = {
  amount: 1000,
  frequency: "weekly",
  custom: false,
  source: '',
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_GIFT_TYPE: {
      const { frequency } = action.payload;
      return {
        ...state,
        frequency: frequency,
      };
    }
    case UPDATE_GIFT_AMOUNT: {
      const { amount } = action.payload;
      return {
        ...state,
        amount: amount,
        custom: false,
      };
    }
    case UPDATE_CUSTOM_GIFT_AMOUNT: {
      const { amount } = action.payload;
      return {
        ...state,
        amount: amount,
        custom: true,
      };
    }

    case UPDATE_SOURCE: {
      const { source } = action.payload;
      return {
        ...state,
        source: source,
      };
    }

    case UPDATE_CUSTOM_GIFT_STATUS: {
      return {
        ...state,
        custom: true,
      };
    }

    default:
      return state;
  }
}
