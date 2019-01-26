import { withFormsy } from 'formsy-react';
import React from 'react';

class MyInput extends React.Component {
  constructor(props) {
    super(props);
    this.changeValue = this.changeValue.bind(this);
  }

  changeValue(event) {
    this.props.setValue(event.currentTarget.value);
  }

  render() {
    const errorMessage = (this.props.getErrorMessage() || (this.props.errorEmpty && !this.props.getValue()));

    return (
      <div className={errorMessage ? this.props.wrapperDivClassName + ' invalid' : this.props.wrapperDivClassName}>
        <label className="uppercase text-xs text-grey-darker block pl-4">{this.props.label}</label>
        <input
        onChange={this.changeValue}
        type="text"
        value={this.props.getValue() || ''}
        className={this.props.className}
        placeholder={this.props.placeholder}
        />
      </div>
    );
  }
}

export default withFormsy(MyInput);
