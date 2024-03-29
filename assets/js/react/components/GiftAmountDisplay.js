import React from 'react';
import { formatPrice } from '../helpers';
import Select from 'react-select';
import { connect } from "react-redux";
import { updateGiftType } from "../redux/actions";

class GiftAmountDisplay extends React.Component {

  updateFrequency = frequency => {
    this.props.updateGiftType(frequency.value);
  }

  render() {
    const { type, currentGiftType, amount, frequency, onBlur } = this.props;

    const options = [
      {value: 'daily', label: 'daily'},
      {value: 'weekly', label: 'weekly'},
      {value: 'bi-weekly', label: 'bi-weekly'},
      {value: 'monthly', label: 'monthly'},
    ]

    if(type === 'one-time') {
      if(type === currentGiftType) {
        return (
          <div className="gift-options">
            <div className="primary-background-color text-white w-full rounded-lg pt-8 text-center pb-4 gift-container">
              <span className="text-5xl font-bold block pb-2 sm:text-xl">{formatPrice(amount)}</span>
              <span className="block border-t pt-2 border-white border-solid mx-8 text-xl font-bold pb-4 capitalize sm:text-base">{type} gift</span>
            </div>
          </div>
        )
      } else {
        return (
          <div className="gift-options">
            <div className="bg-white text-grey-darker w-full rounded-lg pt-8 text-center pb-4 shadow-md gift-container" onClick={() => this.props.updateGiftType(type)}>
              <span className="text-5xl font-bold block pb-2 sm:text-xl">$</span>
              <span className="block border-t pt-2 border-white border-solid mx-8 text-xl font-bold pb-4 capitalize sm:text-base">{type} gift</span>
            </div>
          </div>
        )
      }

    } else {

      if(currentGiftType !== 'one-time') {
        return (
          <div className="gift-options">
            <div className="primary-background-color text-white w-full rounded-lg pt-8 text-center pb-6 gift-container">
              <span className="text-5xl font-bold block pb-2 sm:text-xl">{formatPrice(amount)}</span>
              <Select className="capitalize primary-background-color" disabled={false} options={options} clearable={false} isDisabled={false} searchable={false} value={frequency} onChange={this.updateFrequency}/>
            </div>
          </div>
        )
      } else {
        return (
          <div className="gift-options">
            <div className="bg-white text-grey-darker w-full rounded-lg pt-8 text-center pb-4 shadow-md gift-container" onClick={() => this.props.updateGiftType("weekly")}>
              <span className="text-5xl font-bold block pb-2 sm:text-xl">$</span>
              <span className="block border-t pt-2 border-white border-solid mx-8 text-xl font-bold pb-4 capitalize sm:text-base">Ongoing gift</span>
            </div>
          </div>
        )
      }

    }
  }

}

export default connect(null, { updateGiftType })(GiftAmountDisplay);
