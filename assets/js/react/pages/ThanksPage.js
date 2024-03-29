import React from 'react';
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';

class ThanksPage extends React.Component {

  render() {
    return (
        <div>
          <span className="primary-background-color text-white rounded-full h-32 w-32 flex items-center justify-center mx-auto text-5xl mb-8 mt-8"><img src="/images/Confirm.svg" className="w-16"/></span>

          <h1 className="text-grey-darker text-center">Thank you for your donation!</h1>
          <p className="text-grey-darker text-center text-lg font-thin mt-4">Check your email for your receipt and a verification email if you created an account.</p>
          <div className="mx-auto w-32 mt-8">
            <a href="http://localhost:4200">
              <button className="rounded-full border border-purple-darkest border-solid py-4 px-8 rounded-full mr-8 font-bold text-grey-darker mx-auto">Manage</button>
            </a>
          </div>
        </div>

    )
  }
}

export default withRouter(ThanksPage);
