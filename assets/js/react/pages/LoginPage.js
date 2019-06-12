import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import ButtonBlock from "../components/ButtonBlock";
import Login from "../components/Login";
import { updateProgressStep } from "../redux/actions";


// import Login from "./components/Login";
import { getGiftInfo } from '../redux/selectors';
import { getProgress } from "../redux/selectors";
import { withRouter } from 'react-router-dom';
import { formatPrice } from '../helpers';


class LoginPage extends React.Component {
  progressChange = step => {
    this.props.updateProgressStep(step)
    this.props.history.push(`review`);
  }

  state = {
    formValid: true,
  }

  render() {
      const { frequency, amount, custom } = this.props.giftInfo;
      const { step, reviewing } = this.props.progressInfo;

      return (
        <div>
          <StepTracker />
          <div className="flex mt-8">
            <div className="w-3/5 mx-auto pl-8 sm:w-full sm:px-2">
              <div className="bg-purple text-white rounded-lg pt-6 text-center pb-4 flex overflow-hidden relative">
                <span className="inline-block w-24 pt-3">You are donating</span>
                <div className="flex-1 mb-4">
                  <span className="text-4xl font-semibold block z-10 relative">{formatPrice(amount)}</span>
                  <span className="text-xs -mt-6">As a {frequency} gift.</span>
                  <img src="/images/Davos_icon.svg" className="background-logo ml-4" />
                </div>
                <div className="flex-1"></div>
              </div>
            </div>
          </div>
          <Login authenticate={this.authenticate} formValidity={this.state.formValid} updateFormValidity={this.updateFormValidity}
          progressLoginChange={() => this.progressChange(4)}/>
       </div>
      );
    }
}

export default withRouter(connect(
 state => ({ giftInfo: getGiftInfo(state), progressInfo: getProgress(state) }), {updateProgressStep},
)(LoginPage));
