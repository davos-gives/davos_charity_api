import React from 'react';
import { formatPrice, shortenCreditCard } from '../helpers.js';
import { getPaymentInfo, getGiftInfo, getDonorInfo, getProgress, getStore, getApi } from "../redux/selectors";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import { updateProgressStep } from "../redux/actions";
import { updateReviewingStatus} from "../redux/actions";
import { createResource, setAxiosConfig } from "redux-json-api";
import store from "../redux/store";


import StepTracker from "../components/StepTracker";

class ReviewPage extends React.Component {

  componentWillMount() {
    this.setInReviewFlag();
  }

  setInReviewFlag = () => {
    this.props.updateReviewingStatus();
  }

  submitForm = () => {
    if(this.props.api.vaults) {
      store.dispatch(setAxiosConfig({baseURL: '/api/'}));
      const payment = {
        type: "payments",
        attributes: {
          amount: this.props.giftInfo.amount,
          frequency: "one-time",
          vault_id: this.props.api.vaults.data[0].attributes["iats-id"],
          vault_key: this.props.api["vault-cards"].data[0].attributes["iats-id"],
          donor_id: this.props.api.donors.data[0].id,
          campaign_id: this.props.match.url.split("/")[2],
        }
      }
      store.dispatch(createResource(payment))
      .then(() => {
        this.props.history.push(`thanks`);
      })
    } else {
      store.dispatch(setAxiosConfig({baseURL: '/api/'}));
      const donor = {
        type: 'donors',
        attributes: {
          fname: this.props.donorInfo.fname,
          lname: this.props.donorInfo.lname,
          email: this.props.donorInfo.email,
        },
      }
      store.dispatch(createResource(donor))
      .then(() => {
        const payment = {
          type: "payments",
          attributes: {
            amount: this.props.giftInfo.amount,
            frequency: "one-time",
            cryptogram: this.props.paymentInfo.crypto,
            donor_id: this.props.api.donors.data[0].id,
            campaign_id: this.props.match.url.split("/")[2],
          }
        }
        store.dispatch(createResource(payment))
       .then(() => {
         const address = {
           type: "addresses",
           attributes: {
             name: "default",
             address_1: this.props.donorInfo.address_1,
             city: this.props.donorInfo.city,
             postal_code: this.props.donorInfo.postal_code,
             country: "Canada",
             province: this.props.donorInfo.province,
             donor_id: this.props.api.donors.data[0].id,
           }
         }
         store.dispatch(createResource(address));
       })
       .then(() => {
         this.props.history.push(`thanks`);
       })
      })

    }
  }

  linkTo(step) {
    this.props.history.push(`${step}`)
  }

  render() {
      const donation = this.props.giftInfo;
      const donor = this.props.donorInfo;
      const payment = this.props.paymentInfo;
      const api = this.props.api

      if(api.vaults) {
        return (
          <div>
          <StepTracker />
          <div className="flex mt-8">
            <div className="w-4/5 mx-auto pl-8">
            <form className="flex flex-wrap mt-4">
              <div className="border-b-2 border-purple-darkest pb-3 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4" htmlFor="fname">my name is</label>
                <p className="block mt-2 capitalize text-grey-darker font-semibold pl-4 cursor-pointer" type="text" name="fname" onClick={() => this.linkTo('personal-info')}>{donor.fname} {donor.lname}</p>
              </div>

              <div className="w-1/10"></div>

              <div className="border-b-2 border-purple-darkest pb-3 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">I am donating</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('payment')}>{formatPrice(donation.amount)} as a {donation.frequency} gift</p>
              </div>

              <div className="pb-3 mt-6 w-full">
                <label className="uppercase text-xs text-grey-darker block pl-4">To</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4" >Planned Lifetime Advocacy Network</p>
              </div>

              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-full">
                <label className="uppercase text-xs text-grey-darker block pl-4">Receipt using</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('personal-info')}>{donor.address_1}, {donor.city}, {donor.province}, <span className="uppercase">{donor.postal_code}</span></p>
              </div>

              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">Paying with</label>
                <p className="block mt-2 text-grey-darker pl-4 cursor-pointer" onClick={() => this.linkTo('payment-details')}>{api["vault-cards"].data[0].attributes["card-type"]} card ending with <span className="font-semibold">{api["vault-cards"].data[0].attributes["last-four-digits"]}</span></p>
              </div>
              <div className="w-1/10"></div>
              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">I can be reached at</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('personal-info')}>{donor.email}</p>
              </div>

            </form>
            </div>
          </div>
          <div className="flex mt-8 w-full pr-8 pr-8 ml-8 pl-8 float-right">
            <div className="w-1/2"></div>
            <div className="w-1/2 ml-8">
              <div className="float-right">
                <button className="rounded-full bg-purple-darkest text-white font-thin py-4 px-8 rounded-full mr-6 font-bold mt-5" onClick={this.submitForm.bind(this)}>Donate</button>
              </div>

            </div>
          </div>
          </div>
        );
      } else {
        return (
          <div>
          <StepTracker />
          <div className="flex mt-8">
            <div className="w-4/5 mx-auto pl-8">
            <form className="flex flex-wrap mt-4">
              <div className="border-b-2 border-purple-darkest pb-3 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4" htmlFor="fname">my name is</label>
                <p className="block mt-2 capitalize text-grey-darker font-semibold pl-4 cursor-pointer" type="text" name="fname" onClick={() => this.linkTo('personal-info')}>{donor.fname} {donor.lname}</p>
              </div>

              <div className="w-1/10"></div>

              <div className="border-b-2 border-purple-darkest pb-3 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">I am donating</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('payment')}>{formatPrice(donation.amount)} as a {donation.frequency} gift</p>
              </div>

              <div className="pb-3 mt-6 w-full">
                <label className="uppercase text-xs text-grey-darker block pl-4">To</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4" >Planned Lifetime Advocacy Network</p>
              </div>

              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-full">
                <label className="uppercase text-xs text-grey-darker block pl-4">Receipt using</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('personal-info')}>{donor.address_1}, {donor.city}, {donor.province}, <span className="uppercase">{donor.postal_code}</span></p>
              </div>

              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">Paying with</label>
                <p className="block mt-2 text-grey-darker pl-4 cursor-pointer" onClick={() => this.linkTo('payment-details')}>card ending with <span className="font-semibold"></span></p>
              </div>
              <div className="w-1/10"></div>
              <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-45/100">
                <label className="uppercase text-xs text-grey-darker block pl-4">I can be reached at</label>
                <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('personal-info')}>{donor.email}</p>
              </div>

            </form>
            </div>
          </div>
          <div className="flex mt-8 w-full pr-8 pr-8 ml-8 pl-8 float-right">
            <div className="w-1/2"></div>
            <div className="w-1/2 ml-8">
              <div className="float-right">
                <button className="rounded-full bg-purple-darkest text-white font-thin py-4 px-8 rounded-full mr-6 font-bold mt-5" onClick={this.submitForm.bind(this)}>Donate</button>
              </div>

            </div>
          </div>
          </div>
        );
      }
  }
}
export default withRouter(connect(
 state => ({ donorInfo: getDonorInfo(state), giftInfo: getGiftInfo(state), progressInfo: getProgress(state), paymentInfo: getPaymentInfo(state), store: getStore(state), api: getApi(state) }), {updateProgressStep, updateReviewingStatus},
)(ReviewPage));
