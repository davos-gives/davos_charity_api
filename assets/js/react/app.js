import React from 'react';
import Payments from "./Payments";
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider } from "react-redux";
import store from "./redux/store";

class App extends React.Component {

 render() {
   return (
     <Provider store={store}>
       <Router>
         <Route path="/templates/:id" component={Payments} />
       </Router>
     </Provider>
   )
 }
}

export default App;
