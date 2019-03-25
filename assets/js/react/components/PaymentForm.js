import React from 'react';
import ButtonBlock from './ButtonBlock';
import {Number, Cvc, Expiration} from 'react-credit-card-primitives';
import { connect } from "react-redux";
import { updatePaymentInformation} from "../redux/actions";

class PaymentForm extends React.Component {

  constructor(props) {
    super(props);

    // let paymentInfo = JSON.parse(localStorage.getItem('payment'));

    if(this.props.paymentInfo.number != '') {
      this.state = {
        number: this.props.paymentInfo.number,
        expiry: this.props.paymentInfo.expiry,
        cvv: this.props.paymentInfo.cvv,
        canSubmit: true,
      }

    } else {
    this.state = {
      number: this.props.paymentInfo.number,
      expiry: this.props.paymentInfo.expiry,
      cvv: this.props.paymentInfo.cvv,
      canSubmit: '',
    }
  }
}

  handleCardChange = (event) => {
    this.setState({ number: {value: event.value, valid: event.valid} }, () => {
      this.formButton();
    })
  }

  handleExpiryChange = (event) => {
    let month = parseInt(event.rawValue.split("/")[0]);
    let year = parseInt(event.rawValue.split("/")[1]);
    console.log(event.valid);
    this.setState({ expiry: {
      rawValue: event.rawValue,
      month: month,
      year: year,
      valid: event.valid
    }}, () =>{
      this.formButton();
    })

  }

  formButton = () => {
    if([this.state.number.valid, this.state.expiry.valid, this.state.cvv.valid].every(this.checkFormValidity)) {
      this.setState({ canSubmit: true });
    } else {
      this.setState({ canSubmit: false });

    };
  }

  handleCvvChange = (event) => {
    this.setState({ cvv: {
      focused: event.focused,
      valid: event.valid,
      value: event.value
    } }, () => {
      this.formButton();
    })
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
      <div>
      <div id="checkout-embed"></div>

      <ButtonBlock
        buttonText={"Next"}
        goBack={this.props.goBack}
        handleClick={this.submitForm}
        inReview={this.props.inReview}
        formValid={this.state.canSubmit}
      />
    </div>
    )
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
