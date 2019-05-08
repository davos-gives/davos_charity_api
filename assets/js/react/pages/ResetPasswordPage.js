import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import ButtonBlock from "../components/ButtonBlock";
import PasswordReset from "../components/PasswordReset";
import { updateProgressStep } from "../redux/actions";


// import Login from "./components/Login";
import { getGiftInfo } from '../redux/selectors';
import { getProgress } from "../redux/selectors";
import { withRouter } from 'react-router-dom';
import { formatPrice } from '../helpers';


class ResetPasswordPage extends React.Component {
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
          <div className="flex mt-8 mb-8">
            <div className="w-3/5 mx-auto pl-8 mt-12">
              <p class="font-bold text-base text-grey-dark uppercase">Forgot your password?</p>
              <p class="text-grey-dark text-light mt-4 text-sm leading-normal">Enter your email address below to recover your Davos Account.</p>
            </div>
          </div>
          <PasswordReset authenticate={this.authenticate} formValidity={this.state.formValid} updateFormValidity={this.updateFormValidity}
          progressLoginChange={() => this.progressChange(4)}/>
       </div>
      );
    }
}

export default withRouter(connect(
 state => ({ giftInfo: getGiftInfo(state), progressInfo: getProgress(state) }), {updateProgressStep},
)(ResetPasswordPage));
