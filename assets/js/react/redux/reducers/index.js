import { combineReducers } from "redux";
import giftInfo from "./giftInfo";
import progress from "./progress";
import donorInfo from "./donorInfo";
import paymentInfo from "./paymentInfo";
import activeVaultCard from './activeVaultCard';
import activeSavedAddress from './activeSavedAddress';
import { reducer as api } from 'redux-json-api';


export default combineReducers({
  giftInfo,
  progress,
  donorInfo,
  paymentInfo,
  activeVaultCard,
  activeSavedAddress,
  api,
});
