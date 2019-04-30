import { withFormsy } from 'formsy-react';
import React from 'react';

class MyCheckbox extends React.Component {
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
      <div className={this.props.wrapperDivClassName}>
        <input
        onChange={this.changeValue}
        type="checkbox"
        value={this.props.getValue() || ''}
        className={this.props.className}
        />
        <label className="uppercase text-xs text-grey-darker block pl-4">{this.props.label}</label>

      </div>
    );
  }
}

export default withFormsy(MyCheckbox);
