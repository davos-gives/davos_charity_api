import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import PaymentForm from "../components/PaymentForm";
import { getPaymentInfo, getProgress } from "../redux/selectors";
import { updateProgressStep } from "../redux/actions";

class PaymentDetailsPage extends React.Component {

  progressChange = step => {
    this.props.updateProgressStep(step)
    this.props.history.push(`review`);
  }

  render() {
      const { step, reviewing } = this.props.progressInfo;

      return (
        <div>
          <StepTracker />
          <div className="flex mt-8">
          <PaymentForm
               paymentInfo={this.props.paymentInfo}
               inReview={reviewing}
               progressChange={() => this.progressChange(4)}
             />
          </div>
        </div>
      );
    }
}

export default withRouter(connect(
 state => ({ paymentInfo: getPaymentInfo(state), progressInfo: getProgress(state) }), {updateProgressStep}
)(PaymentDetailsPage));
