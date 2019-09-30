import React from 'react';
import ButtonBlock from './ButtonBlock';
import {Number, Cvc, Expiration} from 'react-credit-card-primitives';
import { connect } from "react-redux";
import store from "../redux/store";
import { updateActiveVaultCardInformation } from "../redux/actions";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { getApi } from "../redux/selectors";
import Formsy from 'formsy-react';
import MyInput from './MyInput';



class NewCardForm extends React.Component {

  constructor(props) {
    super(props);


    this.state = {
      crypto: "",
      canSubmit: "",
      name: "",
    }
  }

  disableButton = () => {
    this.setState({ canSubmit: false });
  }

  enableButton = () => {
    this.setState({ canSubmit: true });
  }

  checkFormValidity = (element, index, array) => {
    return element === true;
  }

  handleInputChange = (event) => {
    this.setState({
      ...event
    })
  }

  submitForm = (newLocation) => {

    store.dispatch(setAxiosConfig({
      baseURL: '/api',
      headers: {
        'Authorization': 'Bearer ' + this.props.api.session.data[0].attributes.token,
      }
    }));

    const crypto = {
      type: "vault-cards",
      attributes: {
        crypto: this.state.crypto,
        vault_key: this.props.api.vaults.data[0].attributes["iats-id"],
        vault_id: this.props.api.vaults.data[0].id,
        name: this.state.name
      }

    }
    store.dispatch(createResource(crypto))
    .then((newVaultCard) => {
      this.props.updateActiveVaultCardInformation({
        cardType: newVaultCard.data.attributes["card-type"],
        iatsId: newVaultCard.data.attributes["iats-id"],
        lastFourDigits: newVaultCard.data.attributes["last-four-digits"],
        name: newVaultCard.data.attributes["name"],
        primary: newVaultCard.data.attributes["primary"],
        id: newVaultCard.data.id,
      })
    })
    this.props.progressChange();

  }


  render() {
    return (
      <div class="w-full">

      <Formsy onChange={this.handleInputChange} className="flex flex-wrap mt-4 w-4/5 mx-auto pl-8 sm:w-full sm:px-2">

          <MyInput
           name="name"
           className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
           validations="minLength:2"
           required
           wrapperDivClassName="border-b border-grey pb-3 mt-6 w-full mb-6"
           label="Credit Card Name:"
           value={this.state.name}
           errorEmpty={false}
           placeholder={"Personal Card"}
          />
        </Formsy>
        <div className="w-4/5 pl-8 mx-auto flex flex-wrap sm:w-full sm:pl-2">
        <iframe className="" id="firstpay-iframe" src="https://secure-v.goemerchant.com/secure/PaymentHostedForm/v3/CreditCard"
          data-transcenter-id="209141" data-processor-id="201173" data-manual-submit="False"
          data-transaction-type="Vault" data-cvv="True" style={{width: 560, height: 250}}></iframe>
        </div>
      <div class="-mt-8">
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
    script.src = "https://secure-v.goemerchant.com/secure/PaymentHostedForm/Scripts/firstpay/firstpay.cryptogram.js";
    script.id = "firstpay-script-cryptogram";
    script.setAttribute("data-transcenter", "209141");
    script.setAttribute("data-processor", "201173");
    script.setAttribute("data-cvv", "TRUE");
    script.setAttribute("data-type", "Vault");
    script.setAttribute("data-autosubmit", "TRUE");
    script.setAttribute("data-styleEmbed", "FALSE");
    document.body.appendChild(script);
    window.addEventListener('message', this.handleFrameTasks);
  }

  componentWillUnmount() {
    window.removeEventListener('message', this.handleFrameTasks);
  }

  handleFrameTasks = (e) => {
    if(e.data.code === 105) {
      this.setState({ crypto: e.data.cryptogram });
      this.setState({ canSubmit: true });
    }
    console.log(e);
  }

}

export default connect(state => ({api: getApi(state)}), {updateActiveVaultCardInformation})(NewCardForm);


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
