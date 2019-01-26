import React from 'react';
import { formatPrice } from '../helpers';
import GiftAmountSelect from "./GiftAmountSelect";
import cx from "classnames";

class GiftAmountBlock extends React.Component {

  floatPosition = () => {
    return ((this.props.currentGiftType == 'one-time') ? 'float-left' : 'float-right' )
  }

  render() {
      return (
        <div>
        <div className={cx("flex mt-8 w-5/6", this.props.currentGiftType != 'one-time' &&  'float-right')}>
          <GiftAmountSelect
            amount={500}
            setAmount={this.props.setAmount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
          <GiftAmountSelect
            amount={1000}
            setAmount={this.props.setAmount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
          <GiftAmountSelect
            amount={3000}
            setAmount={this.props.setAmount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
        </div>
        <div className={cx("flex mt-8 w-5/6", this.props.currentGiftType != 'one-time' &&  'float-right')}>
          <GiftAmountSelect
            amount={5000}
            setAmount={this.props.setAmount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
          <GiftAmountSelect
            amount={10000}
            setAmount={this.props.setAmount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
          <GiftAmountSelect
            isCustom={true}
            setAmount={this.props.amount}
            custom={this.props.custom}
            currentGiftType={this.props.currentGiftType}
          />
        </div>
      </div>
      )
  }
}

export default GiftAmountBlock;
