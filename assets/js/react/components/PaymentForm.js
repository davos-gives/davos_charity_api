import React from 'react';
import ButtonBlock from './ButtonBlock';
import {Number, Cvc, Expiration} from 'react-credit-card-primitives';
import { connect } from "react-redux";
import { updatePaymentInformation} from "../redux/actions";


class PaymentForm extends React.Component {

  constructor(props) {
    super(props);

    if(this.props.paymentInfo.crypto != '') {
      this.state = {
        crypto: "",
        canSubmit: true,
      }

    } else {
    this.state = {
      crypto: "",
      canSubmit: '',
    }
  }
}

  checkFormValidity = (element, index, array) => {
    return element === true;
  }

  submitForm = (newLocation) => {
    this.props.updatePaymentInformation(this.state);
    this.props.progressChange();
  }



  // submitForm = (newLocation) => {
  //   this.props.updatePaymentInformation({
  //     number: this.state.number.value,
  //     expiry: this.state.expiry.rawValue,
  //     cvv: this.state.cvv.value,
  //   });
  //   this.props.progressChange();
  // }

  render() {
    return (
      <div class="w-full flex flex-col relative">
        <div class="w-4/5 mx-auto pl-8">
          <p class="w-full mx-auto uppercase text-xs text-grey-darker block pl-4 mt-8">Credit Card Number</p>
          <div id="checkout-embed" class=""></div>
          <div class="w-4/5 mx-auto flex flex-wrap justify-start expiry-label">
            <p class="w-1/3 uppercase text-xs text-grey-darker block">Expires</p>
            <p class="w-1/3 uppercase text-xs text-grey-darker block ml-2">CVV</p>
          </div>
        </div>
        <div class="">
          <ButtonBlock
            buttonText={"Next"}
            goBack={this.props.goBack}
            handleClick={this.submitForm}
            inReview={this.props.inReview}
            hasBack={true}
            formValid={this.state.canSubmit}
          />
        </div>
      </div>
    )
  }

  componentWillMount() {
  }

  componentDidMount() {
    const script = document.createElement("script");
    script.src = "https://secure-v.goemerchant.com/restgw/cdn/cryptogram.min.js";
    script.id = "checkout-js";
    script.setAttribute("data-transcenter", "209141");
    script.setAttribute("data-processor", "201173");
    script.setAttribute("data-cvv", "TRUE");
    script.setAttribute("data-autosubmit", "TRUE");
    script.setAttribute("data-styleEmbed", "FALSE");
    document.body.appendChild(script);
    window.addEventListener('message', this.handleFrameTasks);
  }

  componentWillUnmount() {
    window.removeEventListener('message', this.handleFrameTasks);
  }

  handleFrameTasks = (e) => {
    console.log(e);
    if(e.data !== "" && e.origin == "https://secure-v.1stpaygateway.net") {
      this.setState({ crypto: e.data });
      this.setState({ canSubmit: true });
    } else {
      this.setState({ canSubmit: false });
    }
  }
}

export default connect(null, {updatePaymentInformation})(PaymentForm);


// Paypal & Apple pay to bring back in later
// <p className="text-xs text-grey-darker block mt-8 mb-8">We also support the following payments</p>
// <div className="flex">
//   <div className="w-1/2 text-center">
//     <img className="w-24" src="/ApplePay.png" />
//   </div>
//   <div className="w-1/2 text-center">
//       <img className="w-24 mt-4" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/PP_logo_h_150x38.png" alt="PayPal Logo" />
//   </div>
// </div>
