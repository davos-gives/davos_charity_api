import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import GiftAmountDisplay from "../components/GiftAmountDisplay";
import GiftAmountBlock from "../components/GiftAmountBlock";
import ButtonBlock from "../components/ButtonBlock";
import { getProgress,  getGiftInfo } from "../redux/selectors";
import { updateProgressStep } from "../redux/actions";

class PaymentPage extends React.Component {

  progressChange = step => {
    if(this.props.progressInfo.reviewing == true) {
      this.props.history.push(`review`);
    } else {
      this.props.history.push(`${this.props.location.pathname}/login`);
      this.props.updateProgressStep(step);
    }
  }

  render() {
      const { frequency, amount, custom } = this.props.giftInfo;
      const { step, reviewing } = this.props.progressInfo;

      return (
        <div>
          <StepTracker />
          <div className="flex justify-around w-full mx-auto mt-8">
            <GiftAmountDisplay
              type="one-time"
              currentGiftType={frequency}
              amount={amount}
            />
            <GiftAmountDisplay
            type="recurring"
            currentGiftType={frequency}
            amount={amount}
            frequency={frequency}
          />
          </div>
          <div className="w-5/6 mx-auto sm:w-full sm:px-2">
            <GiftAmountBlock
              currentGiftType={frequency}
              setAmount={amount}
              custom={custom}
            />
            <ButtonBlock
              handleClick={() => this.progressChange(1)}
              inReview={reviewing}
              formValid={true}
              buttonText={"Next"}
            />
            </div>
        </div>
      );
    }
}

export default withRouter(connect(
 state => ({ giftInfo: getGiftInfo(state), progressInfo: getProgress(state) }), {updateProgressStep}
)(PaymentPage));
