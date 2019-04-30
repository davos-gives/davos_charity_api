import { UPDATE_PERSONAL_INFORMATION } from "../actionTypes";

const initialState = {
  fname: '',
  lname: '',
  email: '',
  address_1: '',
  address_2: '',
  city: '',
  province: 'AB',
  postal_code: '',
  address_id: '',
  address_name: '',
  is_primary: ''
};

export default function(state = initialState, action) {
  switch (action.type) {
    case UPDATE_PERSONAL_INFORMATION: {
      const { info } = action.payload;
      return {
        ...state,
        fname: info.fname,
        lname: info.lname,
        email: info.email,
        address_1: info.address_1,
        address_2: info.address_2,
        address_name: info.address_name,
        city: info.city,
        province: info.province,
        postal_code: info.postal_code,
        address_id: info.address_id,
        is_primary: info.is_primary,
      };
    }
    default:
      return state;
  }
}
