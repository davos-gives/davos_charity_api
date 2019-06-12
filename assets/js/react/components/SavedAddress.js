import React from 'react';
import { connect } from "react-redux";
import ButtonBlock from './ButtonBlock';
import { withRouter } from "react-router-dom";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { updateProgressStep, updatePersonalInformation, updatePaymentInformation } from "../redux/actions";
import { getApi, getProgress  } from "../redux/selectors";


class SavedAddress extends React.Component {

  state = {
    username: '',
    password: '',
  }

  render() {

    let address = this.props.address.attributes;
    let donor = this.props.donor;
    let currentAddressId = this.props.currentAddressId;

    if (currentAddressId == this.props.address.id) {
      return (
        <div class="shadow-lg rounded-lg flex flex-col my-4 px-8 py-4 w-3/4 mx-auto border-b-2 border-purple group cursor-pointer sm:w-full" onClick={() => this.props.updateAddress()}>
          <div class="flex justify-between w-full mb-3 items-center">
            <h1 className="capitalize text-grey-darker text-xl font-heavy">{address.name}</h1>
            {address.primary && <button className="rounded-full text-purple border-solid border border-purple py-1 px-4 text-xs">primary</button>}
          </div>
          <div className="text-grey-darker">
            <p className="">{address["address-2"]}{address["address-1"]}</p>
            <p className="hidden group-hover:block active:block">{address.city}, {address.province}, {address["postal-code"]}</p>
            <p className="hidden group-hover:block active:block">{address.country}</p>
            <p className="hidden group-hover:block active:block">Email: {donor.email}</p>
          </div>
        </div>
      )

    } else {
      return (
        <div className="shadow-lg rounded-lg flex flex-col my-4 px-8 py-4 w-3/4 mx-auto group cursor-pointer sm:w-full" onClick={() => this.props.updateAddress()}>
          <div className="flex justify-between w-full mb-3 items-center">
            <h1 className="capitalize text-grey-darker text-xl font-heavy">{address.name}</h1>
            {address.primary && <button className="rounded-full text-purple border-solid border border-purple py-1 px-4 text-xs">primary</button>}
          </div>
          <div className="text-grey-darker">
            <p className="">{address["address-2"]}{address["address-1"]}</p>
            <p className="hidden group-hover:block active:block">{address.city}, {address.province}, {address["postal-code"]}</p>
            <p className="hidden group-hover:block active:block">{address.country}</p>
            <p className="hidden group-hover:block active:block">Email: {donor.email}</p>
          </div>
        </div>
      )
    }
  }
}

export default withRouter(connect(
 state => ({}), {},
)(SavedAddress));
