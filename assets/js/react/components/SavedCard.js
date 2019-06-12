import React from 'react';
import { connect } from "react-redux";
import ButtonBlock from './ButtonBlock';
import { withRouter } from "react-router-dom";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { updateProgressStep, updatePersonalInformation, updatePaymentInformation } from "../redux/actions";
import { getApi, getProgress  } from "../redux/selectors";


class SavedCard extends React.Component {

  render() {

    let card = this.props.card.attributes;
    let donor = this.props.donor;
    // let currentAddressId = this.props.currentAddressId;
      return (
        <div class="shadow-lg rounded-lg flex flex-col my-4 px-8 py-4 w-3/4 mx-auto border-b-2 border-purple group cursor-pointer sm:w-full">
          <div class="flex justify-between w-full mb-3 items-center">
            <h1 class="capitalize text-grey-darker text-xl font-heavy">{card.name}</h1>
            {card.primary && <button class="rounded-full text-purple border-solid border border-purple py-1 px-4 text-xs">primary</button>}
          </div>
          <div class="text-grey-darker">
            <p class="hidden group-hover:block active:block">{card["card-type"]} ending in {card["last-four-digits"]}</p>
            <p class="hidden group-hover:block active:block mt-1">Expires 11/23</p>

          </div>
        </div>
      )
  }
}

export default withRouter(connect(
 state => ({}), {},
)(SavedCard));


// return (
//   <div class="shadow-lg rounded-lg flex flex-col my-4 px-8 py-4 w-3/4 mx-auto group cursor-pointer" onClick={() => this.props.updateAddress()}>
//     <div class="flex justify-between w-full mb-3 items-center">
//       <h1 class="capitalize text-grey-darker text-xl font-heavy">{card.name}</h1>
//       {card.primary && <button class="rounded-full text-purple border-solid border border-purple py-1 px-4 text-xs">primary</button>}
//     </div>
//     <div class="text-grey-darker">
//       // <p class="">{address["address-2"]}{address["address-1"]}</p>
//       // <p class="hidden group-hover:block active:block">{address.city}, {address.province}, {address["postal-code"]}</p>
//       // <p class="hidden group-hover:block active:block">{address.country}</p>
//       // <p class="hidden group-hover:block active:block">Email: {donor.email}</p>
//     </div>
//   </div>
// )
