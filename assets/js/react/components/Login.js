import React from 'react';
import ButtonBlock from "../components/ButtonBlock";
import store from "../redux/store";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { updateProgressStep, updatePersonalInformation, updatePaymentInformation, updateActiveVaultCardInformation, updateSavedAddressInformation} from "../redux/actions";
import { getApi, getProgress } from "../redux/selectors";


class Login extends React.Component {

  state = {
    username: '',
    password: '',
  }

  componentDidMount() {
    let donor = localStorage.getItem("username");

    if (donor != null) {
      this.setState({
        username: donor
      })
    }
  }

  handleInputChange = (event) => {
    this.setState({
      ...event
    })
  }

  progressChange = step => {
    this.props.updateProgressStep(step)
    this.props.history.push(`personal-info`);
  }

  goBack = () => {
    this.props.history.goBack();
  }

  login = () => {
    store.dispatch(setAxiosConfig({baseURL: '/api/'}));
    const session = {
      type: 'session',
      attributes: {
        email: this.state.username,
        password: this.state.password
      },
    }
    store.dispatch(createResource(session))
    .then(() => {
      store.dispatch(setAxiosConfig({
        baseURL: '/api',
        headers: {
          'Authorization': 'Bearer ' + this.props.api.session.data[0].attributes.token,
        }
      }));
      store.dispatch(readEndpoint("donors/me?include=addresses,vaults"))
      .then(() => {
        store.dispatch(readEndpoint(`vaults/${this.props.api.vaults.data[0].id}/vault_cards`))
        .then(() => {

          let primaryCard = this.props.api["vault-cards"]["data"].find(function(element) {
            return element.attributes.primary == true;
          });

          this.props.updateActiveVaultCardInformation({
            id: primaryCard.id,
            cardType: primaryCard.attributes["card-type"],
            iatsId: primaryCard.attributes["iats-id"],
            lastFourDigits: primaryCard.attributes["last-four-digits"],
            name: primaryCard.attributes.name,
            primary: primaryCard.attributes.primary
          })
        })
        .then(() => {
          this.props.updatePersonalInformation({
            fname: this.props.api.donors.data[0].attributes.fname,
            lname: this.props.api.donors.data[0].attributes.lname,
            email: this.props.api.donors.data[0].attributes.email,
          })
        })
        .then(() => {

          let primaryAddress = this.props.api["addresses"]["data"].find(function(element) {
            return element.attributes.primary == true;
          });

          this.props.updateSavedAddressInformation({
            address_1: primaryAddress.attributes["address-1"],
            address_2: primaryAddress.attributes["address-2"],
            city: primaryAddress.attributes["city"],
            province: primaryAddress.attributes["province"],
            postal_code: primaryAddress.attributes["postal-code"],
            id: primaryAddress.id,
            name: primaryAddress.attributes['name'],
            country: primaryAddress.attributes["country"]
          })
        })
        .then(() => {
          localStorage.setItem("username", this.props.api.donors.data[0].attributes.email);
          this.props.progressLoginChange();
        })
      })
    })
  }

  handleInputChange = (event) => {
    this.setState({
      [event.currentTarget.name]: event.currentTarget.value
    });
  }

  render() {
    const { step, reviewing } = this.props.progressInfo;
    return (
      <div>
        <div>
          <div className="flex mt-4">
            <div className="w-3/5 mx-auto pl-8">
              <div className="bg-white rounded-lg pt-3 pb-3 shadow-md pl-6">
                <label className="uppercase text-xs font-bold text-purple block" for="username">user name</label>
                <input className="block mt-4 outline-none w-full" type="text" name="username" placeholder="Username@email.com" value={this.state.username} onChange={this.handleInputChange}></input>
              </div>
            </div>
          </div>
          <div className="flex mt-4">
            <div className="w-3/5 mx-auto pl-8">
              <div className="bg-white rounded-lg pt-3 pb-3 shadow-md pl-6">
                <label className="uppercase text-xs font-bold text-purple block" for="password">password</label>
                <input className="block mt-4 outline-none" type="password" name="password" placeholder="*************" value={this.state.password} onChange={this.handleInputChange}></input>
              </div>
              <p className="ml-6 text-xs mt-4 text-grey-dark">Forgot password?</p>
            </div>
          </div>
        </div>
        <div className="flex justify-end mr-8 mt-8">
          <button className="underline text-purple text-xs text-center mr-10 cursor" onClick={() => this.progressChange(2)}>Skip for now</button>
        </div>
        <div class="-mt-8">
          <ButtonBlock
            handleClick={() => this.login()}
            inReview={reviewing}
            formValid={true}
            buttonText={"Login with Davos"}
            hasBack={true}
            goBack={() => this.goBack()}
          />
        </div>

      </div>



    )
  }
}

export default withRouter(connect(
 state => ({ api: getApi(state), progressInfo: getProgress(state)}), {updateProgressStep, updatePersonalInformation, updateActiveVaultCardInformation, updateSavedAddressInformation},
)(Login));
