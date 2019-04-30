import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import PersonalInfoForm from "../components/PersonalInfoForm";
import { getDonorInfo, getProgress } from "../redux/selectors";
import { updateProgressStep } from "../redux/actions";

class PersonalInfoPage extends React.Component {

  progressChange = step => {
    if(this.props.progressInfo.reviewing == true) {
      this.props.history.push(`review`);
    } else {
      this.props.updateProgressStep(step);
      this.props.history.push(`payment-details`);
    }
  }

  recognizedDonor = () => {
    console.log('running recognizedDonor')
    this.props.history.push('personal-info-login')
  }

  goBack = () => {
    this.props.history.goBack();
  }

  render() {
      const { step, reviewing } = this.props.progressInfo;

      return (
        <div>
          <StepTracker />
          <div className="flex mt-8">
            <PersonalInfoForm
              inReview={reviewing}
              donorInfo={this.props.donorInfo}
              progressChange={() => this.progressChange(3)}
              recognizedDonor={() => this.recognizedDonor()}
              goBack={() => this.goBack()}
            />
          </div>
        </div>
      );
    }
}

export default withRouter(connect(
 state => ({ donorInfo: getDonorInfo(state), progressInfo: getProgress(state) }), {updateProgressStep}
)(PersonalInfoPage));
