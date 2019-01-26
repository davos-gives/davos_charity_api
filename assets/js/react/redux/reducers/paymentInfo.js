import { UPDATE_PAYMENT_INFORMATION } from "../actionTypes";

const initialState = {
  number: '',
  expiry: '',
  cvv: '',
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_PAYMENT_INFORMATION: {
      const { info } = action.payload;
      return {
        ...state,
        number: info.number,
        cvv: info.cvv,
        expiry: info.expiry,
      };
    }
    default:
      return state;
  }
}
