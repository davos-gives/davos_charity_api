import { UPDATE_ACTIVE_VAULT_CARD_INFORMATION } from "../actionTypes";

const initialState = {
  cardType: "",
  iatsId: "",
  lastFourDigits: "",
  name: "",
  primary: false,
  id: "",
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_ACTIVE_VAULT_CARD_INFORMATION: {
      const { info } = action.payload;
      return {
        ...state,
        cardType: info.cardType,
        iatsId: info.iatsId,
        lastFourDigits: info.lastFourDigits,
        name: info.name,
        primary: info.primary,
        id: info.id
      };
    }
    default:
      return state;
  }
}
