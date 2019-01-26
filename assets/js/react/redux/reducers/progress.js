import { UPDATE_PROGRESS_STEP, UPDATE_REVIEWING_STATUS } from "../actionTypes";

const initialState = {
  step: 1,
  reviewing: false,
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_PROGRESS_STEP: {
      const { step } = action.payload;
      return {
        ...state,
        step: step
      };
    }
    case UPDATE_REVIEWING_STATUS: {
      return {
        ...state,
        reviewing: true
      }
    }
    default:
      return state;
  }
}
