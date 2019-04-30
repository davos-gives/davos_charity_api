import React from "react";
import { Route } from "react-router-dom";
import PaymentPage from "./pages/PaymentPage";
import PaymentDetailsPage from "./pages/PaymentDetailsPage";
import LoginPage from "./pages/LoginPage";
import PersonalInfoPage from "./pages/PersonalInfoPage";
import PersonalInfoLoginPage from "./pages/PersonalInfoLoginPage";
import ReviewPage from "./pages/ReviewPage";
import ThanksPage from "./pages/ThanksPage";

class Payments extends React.Component {

  render() {
    const { match } = this.props;

    return (
      <div>
        <Route exact path={match.path} render={PaymentPage} />
        <Route path={`${match.url}/payment`} render={PaymentPage} />
        <Route path={`${match.url}/login`} render={LoginPage} />
        <Route path={`${match.url}/personal-info`} render={PersonalInfoPage} />
        <Route path={`${match.url}/personal-info-login`} render={PersonalInfoLoginPage} />
        <Route path={`${match.url}/payment-details`} render={PaymentDetailsPage} />
        <Route path={`${match.url}/review`} render={ReviewPage} />
        <Route path={`${match.url}/thanks`} render={ThanksPage} />
      </div>
      );
    }
}

export default Payments;
