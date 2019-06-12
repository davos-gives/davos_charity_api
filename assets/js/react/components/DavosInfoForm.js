import React from 'react';
import Select from 'react-select';
import ButtonBlock from './ButtonBlock';
import MyInput from './MyInput';
import MyCheckbox from './MyCheckbox';
import Formsy from 'formsy-react';
import store from "../redux/store";
import { connect } from "react-redux";
import { updatePersonalInformation, updateSavedAddressInformation } from "../redux/actions";
import { createResource, setAxiosConfig, readEndpoint } from "redux-json-api";
import { getApi } from "../redux/selectors";



class DavosInfoForm extends React.Component {

  constructor(props) {
    super(props);

    this.disableButton = this.disableButton.bind(this);
    this.enableButton = this.enableButton.bind(this);

    this.state = {
      address_1: '',
      address_2: '',
      city: '',
      postal_code: '',
      province: 'AB',
      country: "Canada",
      canSubmit: '',
      name: ''
    }
  }

  state = {
  address_1: '',
  address_2: '',
  city: '',
  postal_code: '',
  province: 'AB',
  country: "Canada",
  canSubmit: '',
  name: ''
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

    store.dispatch(setAxiosConfig({
      baseURL: '/api',
      headers: {
        'Authorization': 'Bearer ' + this.props.api.session.data[0].attributes.token,
      }
    }));

    const address = {
      type: "addresses",
      attributes: {
        address_1: this.state.address_1,
        address_2: this.state.address_2,
        city: this.state.city,
        country: this.state.country,
        postal_code: this.state.postal_code,
        province: this.state.province,
        name: this.state.name

      }
    }
      store.dispatch(createResource(address))
      .then((newAddress) => {
        this.props.updateSavedAddressInformation({
          address_1: newAddress.data.attributes["address-1"],
          address_2: newAddress.data.attributes["address-2"],
          address_name: newAddress.data.attributes.name,
          city: newAddress.data.attributes.city,
          province: newAddress.data.attributes.province,
          postal_code: newAddress.data.attributes["postal-code"],
          id: newAddress.data.id,
          name: newAddress.data.attributes["name"],
          primary: newAddress.data.attributes["primary"]
        })
      })
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
      <Formsy onChange={this.handleInputChange} onValidSubmit={this.submitForm} onValid={this.enableButton} onInvalid={this.disableButton} className="flex flex-wrap mt-4 w-4/5 mx-auto pl-8 sm:w-full sm:px-2">

          <MyInput
           name="name"
           className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
           validations="minLength:2"
           required
           wrapperDivClassName="border-b border-grey pb-3 mt-6 w-full"
           label="Address name"
           value={this.state.name}
           errorEmpty={false}
           placeholder={"Home"}
          />

           <MyInput
            name="address_1"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none w-full"
            validations="minLength:2"
            required
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-7/10 sm:w-full"
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
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-1/5 sm:w-full"
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
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-266 sm:w-full"
            label="city"
            value={this.state.city}
            errorEmpty={false}
            placeholder={"Hobbiton"}
           />
           <div className="w-1/10 sm:hidden"></div>

           <div className="border-b border-grey mt-6 w-266 sm:w-1/3">
             <label className="uppercase text-xs text-grey-darker block pl-4" htmlFor="province">Province</label>

             <Select className="block mt-2 text-grey-darker font-semibold pl-4 w-24 capitalize outline-none province" options={provinces} clearable={false} searchable={false} placeholder="select an option" value={this.state.province} onChange={this.updateProvince} name="province"/>
           </div>

           <div className="w-1/10"></div>

           <MyInput
            name="postal_code"
            className="block mt-2 text-grey-darker font-semibold pl-4 outline-none fname"
            validations="isAlphanumeric,isLength:6"
            validationError="this is not a valid email"
            wrapperDivClassName="border-b border-grey pb-3 mt-6 w-266 sm:w-1/3"
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

export default connect(state => ({api: getApi(state)}), {updatePersonalInformation, updateSavedAddressInformation})(DavosInfoForm);
