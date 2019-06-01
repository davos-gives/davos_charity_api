import React from 'react';
import ButtonBlock from "../components/ButtonBlock";
import store from "../redux/store";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { updateProgressStep, updatePersonalInformation, updatePaymentInformation, updateActiveVaultCardInformation, updateSavedAddressInformation} from "../redux/actions";
import { getApi, getProgress } from "../redux/selectors";


class PasswordReset extends React.Component {

  state = {
    username: '',
    requested: false,
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

  resetPassword = () => {
    this.props.history.push(`reset-password`);
  }

  requestReset = () => {
    store.dispatch(setAxiosConfig({baseURL: '/api/'}));

    store.dispatch(readEndpoint(`donors/reset-password?email=${this.state.username}`))
    .then(() => {
      this.setState({
        requested: true
      })
    });


  }

  handleInputChange = (event) => {
    this.setState({
      [event.currentTarget.name]: event.currentTarget.value
    });
  }

  render() {
    const { step, reviewing } = this.props.progressInfo;

    if(this.state.requested) {
      return (
        <div>
          <div>
            <div className="flex mt-4">
              <div className="w-3/5 mx-auto pl-8">
                <div className="bg-white rounded-lg pt-3 pb-3 shadow-md pl-6">
                  <label className="uppercase text-xs font-bold text-purple block" for="username">Email Address</label>
                  <input className="block mt-4 outline-none w-full" type="text" name="username" placeholder="Username@email.com" value={this.state.username} onChange={this.handleInputChange}></input>
                </div>
                <p class="mt-6 text-purple leading-loose">Request sent! Check your inbox for your password reset email.</p>
              </div>
            </div>
          </div>
          <div class="h-24 -mt-3">
          </div>
          <div className="flex justify-end mr-8 -mt-12 pt-1">
            <button className="underline text-purple text-xs text-center mr-10 cursor" onClick={() => this.progressChange(2)}>Skip for now</button>
          </div>
          <div class="-mt-8">
            <ButtonBlock
              handleClick={() => this.requestReset()}
              inReview={reviewing}
              formValid={true}
              buttonText={"Request Reset Link"}
              hasBack={true}
              goBack={() => this.goBack()}
            />
          </div>
        </div>
      )
    } else {
      return (
        <div>
          <div>
            <div className="flex mt-4">
              <div className="w-3/5 mx-auto pl-8">
                <div className="bg-white rounded-lg pt-3 pb-3 shadow-md pl-6">
                  <label className="uppercase text-xs font-bold text-purple block" for="username">Email Address</label>
                  <input className="block mt-4 outline-none w-full" type="text" name="username" placeholder="Username@email.com" value={this.state.username} onChange={this.handleInputChange}></input>
                </div>
              </div>
            </div>
          </div>
          <div class="h-24">
          </div>
          <div className="flex justify-end mr-8 mt-8">
            <button className="underline text-purple text-xs text-center mr-10 cursor" onClick={() => this.progressChange(2)}>Skip for now</button>
          </div>
          <div class="-mt-8">
            <ButtonBlock
              handleClick={() => this.requestReset()}
              inReview={reviewing}
              formValid={true}
              buttonText={"Request Reset Link"}
              hasBack={true}
              goBack={() => this.goBack()}
            />
          </div>
        </div>
      )
    }
  }
}

export default withRouter(connect(
 state => ({ api: getApi(state), progressInfo: getProgress(state)}), {updateProgressStep, updatePersonalInformation, updateActiveVaultCardInformation, updateSavedAddressInformation},
)(PasswordReset));
