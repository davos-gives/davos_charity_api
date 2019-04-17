import { UPDATE_PAYMENT_INFORMATION } from "../actionTypes";

const initialState = {
  crypto: "",
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_PAYMENT_INFORMATION: {
      const { info } = action.payload;
      return {
        ...state,
        crypto: info.crypto,
      };
    }
    default:
      return state;
  }
}
