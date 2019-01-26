import React from 'react';

class ButtonBlock extends React.Component {

  render() {
    if(this.props.inReview) {
      return (
      <button className="rounded-full bg-purple-darkest text-white font-thin py-4 px-8 rounded-full mr-6 font-bold mt-8 float-right outline-none" onClick={() => this.props.handleClick()}>Return to Review</button>
      )
    } else {
     if(!this.props.formValid) {
       return (
           <button className="rounded-full bg-orange text-white font-thin py-4 px-8 rounded-full font-bold mt-8 float-right outline-none opacity-50 cursor-not-allowed">{this.props.buttonText}</button>
       )
     } else {
        if(this.props.hasBack) {
          return (
            <div className="flex mt-8 w-full pr-8 pr-8 ml-8 pl-8 float-right">
              <div className="w-1/2 ml-8">
                <button className="rounded-full border border-purple-darkest border-solid py-4 px-8 rounded-full mr-8 font-bold mt-5 text-grey-darker mx-auto outline-none" onClick={this.props.goBack}>Back</button>
              </div>
              <div className="w-1/2 ml-8">
                <div className="float-right">
                  <button className="rounded-full bg-orange text-white font-thin py-4 px-8 rounded-full mr-6 font-bold mt-5 outline-none" onClick={() => this.props.handleClick()}>{this.props.buttonText}</button>
                </div>
              </div>
            </div>
          )
        } else {
          return (
          <button className="rounded-full bg-orange text-white font-thin py-4 px-8 rounded-full font-bold mt-8 float-right outline-none" onClick={() => this.props.handleClick()}>{this.props.buttonText}</button>
          )
        }
      }
    }
  }
}
export default ButtonBlock;
