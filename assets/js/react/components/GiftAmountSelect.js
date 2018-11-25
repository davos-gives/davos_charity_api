import React from 'react';
import { connect } from "react-redux";
import { formatPrice } from '../helpers';
import { updateGiftAmount, updateCustomGiftAmount, updateCustomGiftStatus } from "../redux/actions";

class GiftAmountSelect extends React.Component {

  customChange = event => {
    let newValue = (event.currentTarget.value * 100)
    this.props.updateCustomGiftAmount(newValue)
  }

  floatPosition = () => {
    return ((this.props.currentGiftType == 'one-time') ? 'float-left' : 'float-right' )
  }

  render() {
    const { amount, isCustom, custom } = this.props;
    if(this.props.isCustom == true) {
      if(this.props.custom == true) {
        return (
          <div className="w-1/3">
            <div className={"bg-white shadow-md rounded-lg text-grey-darker w-29 pt-6 pb-5 text-lg text-center border-b-4 font-bold border-orange " + this.floatPosition()} onClick={() => this.props.updateCustomGiftStatus()}>
              <input className="text-grey-darker font-bold w-20 border-none ml-2 outline-none" type="text"  placeholder="Custom" value={this.props.amount} onChange={this.customChange}  />
            </div>
          </div>
        )
      } else {
      return (
        <div className="w-1/3">
          <div className={"bg-white shadow-md rounded-lg text-grey-darker w-29 pt-6 pb-6 text-lg text-center font-bold " + this.floatPosition()} onClick={() => this.props.updateCustomGiftStatus()}>
            <input className="text-grey-darker font-bold w-20 border-none ml-2 text-center outline-none" type="string" placeholder="Custom" value={this.props.amount} onChange={this.customChange} />
          </div>
        </div>
      )
    }
  }

    if(this.props.amount === this.props.setAmount && !this.props.custom) {
      return (
      <div className="w-1/3">
        <div className={"bg-white shadow-md rounded-lg text-grey-darker w-29 pt-6 pb-5 text-lg text-center border-b-4 font-bold border-orange cursor-pointer " + this.floatPosition()} onClick={this.handleClick}>
          {formatPrice(this.props.amount)}
        </div>
      </div>
      )
    }
      return (
        <div className="w-1/3">
          <div className={"bg-white shadow-md rounded-lg text-grey-darker w-29 py-6 text-lg text-center cursor-pointer " + this.floatPosition()} onClick={() => this.props.updateGiftAmount(amount)}>
            {formatPrice(this.props.amount)}
          </div>
        </div>
      )
  }

}

export default connect(null, { updateGiftAmount, updateCustomGiftAmount, updateCustomGiftStatus })(GiftAmountSelect);
