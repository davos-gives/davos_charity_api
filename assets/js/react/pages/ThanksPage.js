import React from 'react';
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';

class ThanksPage extends React.Component {

  render() {
    return (
        <div>
          <span className="bg-purple-darkest text-white rounded-full h-32 w-32 flex items-center justify-center mx-auto text-5xl mb-8 mt-8"><img src="/images/Confirm.svg" className="w-16"/></span>

          <h1 className="text-grey-darker text-center">Thank you for your donation!</h1>
          <p className="text-grey-darker text-center text-lg font-thin mt-4">Check your email for your receipt</p>
          <div className="mx-auto w-32">
            <button className="rounded-full border border-purple-darkest border-solid py-4 px-8 rounded-full mr-8 font-bold mt-5 text-grey-darker mx-auto mb-8 mt-8">Receipt</button>
            <a href="https://my.davos.gives/">
              <button className="rounded-full border border-purple-darkest border-solid py-4 px-8 rounded-full mr-8 font-bold text-grey-darker mx-auto">Manage</button>
            </a>
          </div>
        </div>

    )
  }
}

export default withRouter(ThanksPage);
