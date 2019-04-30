import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import ButtonBlock from "../components/ButtonBlock";
import InfoLogin from "../components/InfoLogin";
import { updateProgressStep } from "../redux/actions";


// import Login from "./components/Login";
import { getGiftInfo } from '../redux/selectors';
import { getProgress } from "../redux/selectors";
import { withRouter } from 'react-router-dom';
import { formatPrice } from '../helpers';


class PersonalInfoLoginPage extends React.Component {
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
          <InfoLogin authenticate={this.authenticate} formValidity={this.state.formValid} updateFormValidity={this.updateFormValidity}
          progressLoginChange={() => this.progressChange(4)}/>
       </div>
      );
    }
}

export default withRouter(connect(
 state => ({ giftInfo: getGiftInfo(state), progressInfo: getProgress(state) }), {updateProgressStep},
)(PersonalInfoLoginPage));
