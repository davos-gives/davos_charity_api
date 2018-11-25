import React from 'react';
import TodoApp from "./TodoApp";
import PaymentPage from "./PaymentPage";

import { Provider } from "react-redux";
import store from "./redux/store";

class App extends React.Component {

 render() {
   return (
     <Provider store={store}>
       <PaymentPage />
     </Provider>
   )
 }
}


export default App;
