import React from 'react';
import ButtonBlock from "../components/ButtonBlock";
import store from "../redux/store";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { updateProgressStep, updatePersonalInformation, updatePaymentInformation } from "../redux/actions";
import { getApi, getProgress  } from "../redux/selectors";


class InfoLogin extends React.Component {

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
    this.props.history.push(`payment-details`);
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
          this.props.updatePersonalInformation({
            fname: this.props.api.donors.data[0].attributes.fname,
            lname: this.props.api.donors.data[0].attributes.lname,
            email: this.props.api.donors.data[0].attributes.email,
            address_1: this.props.api.addresses.data[0].attributes["address-1"],
            city: this.props.api.addresses.data[0].attributes.city,
            province: this.props.api.addresses.data[0].attributes.province,
            postal_code: this.props.api.addresses.data[0].attributes["postal-code"],
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
            <div className="w-3/5 mx-auto pl-8 sm:w-full sm:px-2">
              <div className="bg-white pt-3 pb-3 pl-2 border-b-2">
                <label className="uppercase text-xs font-bold text-grey-darker block" for="email">Email</label>
                <input className="block mt-4 outline-none text-purple text-lg font-extrabold" type="email" name="email" placeholder="" value={this.state.username} onChange={this.handleInputChange}></input>
              </div>
              <p class="text-sm text-purple pl-2 mt-2">Your email address already has a <span class="font-extrabold">Davos</span> account!</p>
              <p class="pl-2 mt-8 mb-4">Enter your password to donate with just a few clicks</p>
            </div>
          </div>
          <div className="flex mt-4">
            <div className="w-3/5 mx-auto pl-8 sm:w-full sm:px-2">
            <div className="bg-white rounded-lg pt-3 pb-3 shadow-md pl-6">
              <label className="uppercase text-xs font-bold text-purple block" for="password">password</label>
              <input className="block mt-4 outline-none" type="password" name="password" placeholder="*************" value={this.state.password} onChange={this.handleInputChange}></input>
            </div>
            <p className="ml-6 text-xs mt-4 text-grey-dark">Forgot password?</p>
          </div>
          </div>
        </div>
        <div className="flex justify-end mr-2 mt-8">
          <button className="underline text-purple text-xs text-center mr-10 cursor" onClick={() => this.progressChange(3)}>Skip for now</button>
        </div>
        <div class="-mt-8">
          <ButtonBlock
            handleClick={() => this.login()}
            inReview={reviewing}
            formValid={true}
            buttonText={"Next"}
            hasBack={true}
            goBack={() => this.goBack()}
          />
        </div>

      </div>



    )
  }
}

export default withRouter(connect(
 state => ({ api: getApi(state), progressInfo: getProgress(state)}), {updateProgressStep, updatePersonalInformation},
)(InfoLogin));
