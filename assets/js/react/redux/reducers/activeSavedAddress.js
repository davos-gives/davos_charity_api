import { UPDATE_SAVED_ADDRESS_INFORMATION } from "../actionTypes";

const initialState = {
  address_1: '',
  address_2: '',
  city: '',
  province: '',
  postal_code: '',
  country: '',
  id: '',
  name: '',
  primary: ''
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_SAVED_ADDRESS_INFORMATION: {
      const { info } = action.payload;
      return {
        ...state,
        address_1: info.address_1,
        address_2: info.address_2,
        address_name: info.address_name,
        city: info.city,
        province: info.province,
        postal_code: info.postal_code,
        id: info.id,
        primary: info.primary,
        country: info.country,
      };
    }
    default:
      return state;
  }
}
