import { combineReducers } from "redux";
import giftInfo from "./giftInfo";
import progress from "./progress";
import donorInfo from "./donorInfo";
import paymentInfo from "./paymentInfo";

export default combineReducers({
  giftInfo,
  progress,
  donorInfo,
  paymentInfo
});
