import React from 'react';
import Select from 'react-select';
import ButtonBlock from './ButtonBlock';
import MyInput from './MyInput';
import MyCheckbox from './MyCheckbox';
import Formsy from 'formsy-react';
import store from "../redux/store";
import { connect } from "react-redux";
import { updatePersonalInformation } from "../redux/actions";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";



class DavosInfoForm extends React.Component {

  constructor(props) {
    super(props);

    this.disableButton = this.disableButton.bind(this);
    this.enableButton = this.enableButton.bind(this);

    this.state = {
      fname: this.props.donorInfo.fname,
      lname: this.props.donorInfo.lname,
      email: this.props.donorInfo.email,
      province: "AB"
    }
  }

  state = {
  address_1: '',
  address_2: '',
  city: '',
  postal_code: '',
  province: 'AB',
  canSubmit: '',
}


  invalid = (element) => {
    return element === false;
  }

  handleInputChange = (event) => {
    this.setState({
      ...event
    })
  }

  updateProvince = (event) => {
    this.setState({
      province: event.value
    });
  }

  submitForm = () => {
    this.props.updatePersonalInformation(this.state);
    this.props.progressChange();

  }

  disableButton = () => {
    this.setState({ canSubmit: false });
  }

  enableButton = () => {
    this.setState({ canSubmit: true });
  }

  goBack = () => {
    this.props.goBack();
  }

  render() {

    const provinces = [
      {value: 'AB', label: 'AB'},
      {value: 'BC', label: 'BC'},
      {value: 'MB', label: 'MB'},
      {value: 'NB', label: 'NB'},
      {value: 'NL', label: 'NL'},
      {value: 'NS', label: 'NS'},
      {value: 'NT', label: 'NT'},
      {value: 'NU', label: 'NU'},
      {value: 'ON', label: 'ON'},
      {value: 'QC', label: 'QC'},
      {value: 'SK', label: 'SK'},
      {value: 'YT', label: 'YT'},
      {value: 'PE', label: 'PE'},
    ]

    return (
      <div>
      <h1 className="w-4/5 mx-auto pl-10 text-purple text-lg font-semibold">Add New Address</h1>
      <Formsy onChange={this.handleInputChange} onValidSubmit={this.submitForm} onValid={this.enableButton} onInvalid={this.disableButton} className="flex flex-wrap mt-4 w-4/5 mx-auto pl-8">

          <MyInput
           name="address_name"
           className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
           validations="minLength:2"
           required
           wrapperDivClassName="border-b border-grey pb-3 mt-6 w-full"
           label="Address name"
           value={this.state.address_name}
           errorEmpty={false}
           placeholder={"Home"}
          />

           <MyInput
            name="address_1"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
            validations="minLength:2"
            required
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-7/10"
            label="street"
            value={this.state.address_1}
            errorEmpty={false}
            placeholder={"1 bagshot row"}
           />

           <div className="w-1/10"></div>


           <MyInput
            name="address_2"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none fname"
            validations="isAlphanumeric"
            validationError="this is not a valid apartment Number"
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-1/5"
            label="apt"
            value={this.state.address_2}
            errorEmpty={false}
            placeholder={"123"}
           />

           <MyInput
            name="city"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none fname"
            validations="isAlphanumeric,minLength:2"
            validationError="this is not a valid city name"
            required
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-266"
            label="city"
            value={this.state.city}
            errorEmpty={false}
            placeholder={"Hobbiton"}
           />
           <div className="w-1/10"></div>

           <div className="border-b border-grey mt-6 w-266">
             <label className="uppercase text-xs text-grey-darker block pl-4" htmlFor="province">Province</label>

             <Select className="block mt-2 text-grey-darker font-semibold pl-4 w-24 capitalize outline-none province" options={provinces} clearable={false} searchable={false} placeholder="select an option" value={this.state.province} onChange={this.updateProvince} name="province"/>
           </div>

           <div className="w-1/10"></div>

           <MyInput
            name="postal_code"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none fname"
            validations="isAlphanumeric,isLength:6"
            validationError="this is not a valid email"
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-266"
            required
            label="postal code"
            value={this.state.postal_code}
            errorEmpty={false}
            placeholder={"V5A0B9"}
           />

           <MyCheckbox
            name="isPrimary"
            className="outline-none"
            wrapperDivClassName="mt-8 ml-4 flex"
            label="Make this my preferred address"
            value={this.state.isPrimary}
            errorEmpty={false}
            placeholder={"V5A0B9"}
           />
     </Formsy>
     <ButtonBlock
       handleClick={() => this.submitForm()}
       formValid={this.state.canSubmit}
       inReview={this.props.inReview}
       buttonText={"Next"}
       hasBack={true}
       goBack={() => this.goBack()}
     />
     </div>
   );
  }
}

export default connect(null, {updatePersonalInformation})(DavosInfoForm);
