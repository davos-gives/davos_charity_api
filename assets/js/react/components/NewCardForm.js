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

      <Formsy onChange={this.handleInputChange} onValid={this.enableButton} onInvalid={this.disableButton} className="flex flex-wrap mt-4 w-4/5 mx-auto pl-8">

          <MyInput
           name="name"
           className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
           validations="minLength:2"
           required
           wrapperDivClassName="border-b border-grey pb-3 mt-6 w-full mb-6"
           label="Credit Card Name"
           value={this.state.name}
           errorEmpty={false}
           placeholder={"Personal Card"}
          />
        </Formsy>

        <div id="checkout-embed" class="h-24"></div>
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

  // <!-- <script src="https://secure-v.goemerchant.com//restgw/cdn/cryptogram.min.js"
  // id="checkout-js" type="text/javascript"
  // data-transcenter="209141"
  // data-processor="201173"
  // data-styleembed=TRUE
  // data-cvv=TRUE
  // data-autosubmit="TRUE"
  // ></script> -->


  componentDidMount() {
    const script = document.createElement("script");
    script.src = "https://secure-v.goemerchant.com/restgw/cdn/cryptogram.min.js";
    script.id = "checkout-js";
    script.setAttribute("data-transcenter", "209141");
    script.setAttribute("data-processor", "201173");
    script.setAttribute("data-cvv", "TRUE");
    script.setAttribute("data-type", "Vault");
    script.setAttribute("data-autosubmit", "TRUE");
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
