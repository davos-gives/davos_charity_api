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
      <div className="flex mt-8">
        <div className="w-4/5 mx-auto pl-8">
        <form className="flex flex-wrap mt-4">
          <div className="w-full">
            <Number
              onChange={this.handleCardChange}
              masked={true}
              value={this.state.number.value}
              render={({
                getInputProps,
                valid,
                type
              }) => <div className={valid ? "relative border-b border-grey pb-3" : "relative invalid border-b border-grey pb-3"} >
                <label className={"uppercase text-xs text-grey-darker block pl-4 " + `${type}`}>Card number</label>
                <input {...getInputProps()} className='block mt-2 capitalize text-grey-darker font-semibold pl-4 outline-none' /> </div> }
            />
          </div>

          <div className="w-1/4">
          <Expiration
            onChange={this.handleExpiryChange}
            month={this.state.expiry.month}
            year={this.state.expiry.year}
            render={({
              getInputProps,
              valid,
              error
            }) => (
              <div className={this.state.expiry.valid ? "border-b border-grey pb-3 mt-6" : "border-b border-grey pb-3 mt-6 invalid"}>
                <label className="uppercase text-xs text-grey-darker block pl-4" htmlFor="lname">expires</label>
                <input {...getInputProps()} className="inline-block mt-2 capitalize text-grey-darker font-semibold pl-4 w-24 outline-none" />
              </div>
            )} />
          </div>

          <div className="w-1/10"></div>

          <Cvc
            onChange={this.handleCvvChange}
            value={this.state.cvv.value}
            render={({
              getInputProps,
              valid
            }) => (
              <div className={valid ? "border-b border-grey pb-3 mt-6 w-1/5" : "border-b border-grey pb-3 mt-6 w-1/5 invalid"}>
                <label className="uppercase text-xs text-grey-darker block pl-4">CVV</label>
                <input {...getInputProps()} className="block mt-2 text-grey-darker font-semibold pl-4 w-24 outline-none" />
              </div>
              )}
          />
        </form>
        </div>
      </div>

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
