import React from "react";
import AddTodo from "./components/AddTodo";
import TodoList from "./components/TodoList";
import StepTracker from "./components/StepTracker";
import { connect } from "react-redux";
import GiftAmountDisplay from "./components/GiftAmountDisplay";
import GiftAmountBlock from "./components/GiftAmountBlock";
import { getGiftInfo } from './redux/selectors';

class PaymentPage extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
      const { frequency, amount, custom } = this.props.giftInfo

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
          <div className="w-5/6 mx-auto">
          <GiftAmountBlock
            currentGiftType={frequency}
            setAmount={amount}
            custom={custom}
          /></div>
        </div>
      );
    }
}

export default connect(
 state => ({ giftInfo: getGiftInfo(state) }),
)(PaymentPage);
