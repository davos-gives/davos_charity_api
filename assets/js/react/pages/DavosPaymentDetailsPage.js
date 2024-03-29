import React from "react";
import StepTracker from "../components/StepTracker";
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import PersonalInfoForm from "../components/PersonalInfoForm";
import SavedAddress from "../components/SavedAddress";
import SavedCard from "../components/SavedCard";

import ButtonBlock from "../components/ButtonBlock";
import { getDonorInfo, getProgress, getApi } from "../redux/selectors";
import { updateProgressStep, updatePersonalInformation } from "../redux/actions";

class DavosPaymentDetailsPage extends React.Component {

  updateAddress = address => {
    this.props.updatePersonalInformation({
      fname: this.props.donorInfo.fname,
      lname: this.props.donorInfo.lname,
      email: this.props.donorInfo.email,
      address_1: address.attributes["address-1"],
      address_2: address.attributes["address-2"],
      address_name: address.attributes.name,
      city: address.attributes.city,
      province: address.attributes.province,
      postal_code: address.attributes["postal-code"],
      address_id: address.id
    })
  }

  progressChange = step => {
    if(this.props.progressInfo.reviewing == true) {
      this.props.history.push(`review`);
    } else {
      this.props.updateProgressStep(step);
      this.props.history.push(`payment-details`);
    }
  }

  addCard = () => {
    this.props.history.push('add-davos-card')
  }

  goBack = () => {
    this.props.history.goBack();
  }

  render() {
      const { step, reviewing } = this.props.progressInfo;

      let cards = this.props.api["vault-cards"]["data"];

      return (
        <div>
          <StepTracker />
          <div className="flex mt-8 flex-col">
            {cards.map(card => <SavedCard key={card.id} card={card} donor={this.props.donorInfo} />)}
            <div class="shadow-lg rounded-lg flex flex-col my-4 px-8 py-4 w-3/4 mx-auto group cursor-pointer">
              <p class="text-grey-darker font-lg text-center" onClick={() => this.addCard()}>Add New Card</p>
            </div>
          </div>
          <ButtonBlock
            handleClick={() => this.progressChange(4)}
            inReview={reviewing}
            formValid={true}
            buttonText={"Next"}
          />
        </div>
      );
    }
}

export default withRouter(connect(
 state => ({ donorInfo: getDonorInfo(state), progressInfo: getProgress(state), api: getApi(state) }), {updateProgressStep, updatePersonalInformation}
)(DavosPaymentDetailsPage));
