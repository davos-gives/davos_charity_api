import React from 'react';
import { formatPrice, shortenCreditCard } from '../helpers.js';
import { getPaymentInfo, getGiftInfo, getDonorInfo, getProgress } from "../redux/selectors";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import StepTracker from "../components/StepTracker";
import { updateProgressStep } from "../redux/actions";
import { updateReviewingStatus } from "../redux/actions";



class ReviewPage extends React.Component {

  componentWillMount() {
    this.setInReviewFlag();
  }

  setInReviewFlag = () => {
    this.props.updateReviewingStatus();
  }

  submitForm() {
    this.props.history.push(`thanks`);
  }

  linkTo(step) {
    this.props.history.push(`${step}`)
  }

  render() {
      const donation = this.props.giftInfo;
      const donor = this.props.donorInfo;
      const payment = this.props.paymentInfo;

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
              <p className="block mt-2 text-grey-darker font-semibold pl-4" >BC SPCAs Coats for Canines campaign</p>
            </div>

            <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-full">
              <label className="uppercase text-xs text-grey-darker block pl-4">Receipt using</label>
              <p className="block mt-2 text-grey-darker font-semibold pl-4 cursor-pointer" onClick={() => this.linkTo('personal-info')}>{donor.address_1}, {donor.city}, {donor.province}, <span className="uppercase">{donor.postal_code}</span></p>
            </div>


            <div className="border-b-2 border-purple-darkest pb-3 mt-6 w-45/100">
              <label className="uppercase text-xs text-grey-darker block pl-4">Paying with</label>
              <p className="block mt-2 text-grey-darker pl-4 cursor-pointer" onClick={() => this.linkTo('payment-details')}>card ending with <span className="font-semibold">{shortenCreditCard(payment.number.value)}</span></p>
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
              <button className="rounded-full bg-purple-darkest text-white font-thin py-4 px-8 rounded-full mr-6 font-bold mt-5" onClick={() => this.submitForm()}>Donate</button>
            </div>

          </div>
        </div>
        </div>
      );
  }
}
export default withRouter(connect(
 state => ({ donorInfo: getDonorInfo(state), giftInfo: getGiftInfo(state), progressInfo: getProgress(state), paymentInfo: getPaymentInfo(state) }), {updateProgressStep, updateReviewingStatus},
)(ReviewPage));
